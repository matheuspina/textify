"""
Testes para o módulo de conversão de arquivos.
"""

import pytest
import sys
import os

# Adiciona o diretório src ao path para importar os módulos
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'src'))

from file_converter import extract_text_from_file, SUPPORTED_FORMATS


class TestFileConverter:
    """Testes para a classe FileConverter."""

    def test_supported_formats_not_empty(self):
        """Testa se a lista de formatos suportados não está vazia."""
        assert len(SUPPORTED_FORMATS) > 0

    def test_supported_formats_contains_common_types(self):
        """Testa se os formatos mais comuns estão na lista."""
        expected_formats = ['PDF', 'DOCX', 'TXT', 'HTML', 'JSON']
        for format_type in expected_formats:
            assert format_type in SUPPORTED_FORMATS

    def test_extract_text_from_txt_file(self):
        """Testa extração de texto de arquivo TXT."""
        # Arrange
        text_content = "Este é um texto de teste."
        file_content = text_content.encode('utf-8')
        
        # Act
        result = extract_text_from_file(file_content, "txt")
        
        # Assert
        assert result["success"] is True
        assert result["extracted_text"] == text_content
        assert result["file_size"] == len(file_content)

    def test_extract_text_from_json_file(self):
        """Testa extração de texto de arquivo JSON."""
        # Arrange
        json_content = '{"message": "Hello, World!", "number": 42}'
        file_content = json_content.encode('utf-8')
        
        # Act
        result = extract_text_from_file(file_content, "json")
        
        # Assert
        assert result["success"] is True
        assert "Hello, World!" in result["extracted_text"]
        assert "42" in result["extracted_text"]

    def test_extract_text_from_html_file(self):
        """Testa extração de texto de arquivo HTML."""
        # Arrange
        html_content = "<html><body><h1>Título</h1><p>Parágrafo de teste.</p></body></html>"
        file_content = html_content.encode('utf-8')
        
        # Act
        result = extract_text_from_file(file_content, "html")
        
        # Assert
        assert result["success"] is True
        assert "Título" in result["extracted_text"]
        assert "Parágrafo de teste" in result["extracted_text"]

    def test_unsupported_format_raises_error(self):
        """Testa se formato não suportado levanta exceção."""
        # Arrange
        file_content = b"conteudo qualquer"
        
        # Act & Assert
        with pytest.raises(Exception):
            extract_text_from_file(file_content, "xyz")

    def test_empty_file_content(self):
        """Testa comportamento com conteúdo vazio."""
        # Arrange
        file_content = b""
        
        # Act
        result = extract_text_from_file(file_content, "txt")
        
        # Assert
        assert result["success"] is True
        assert result["extracted_text"] == ""
        assert result["file_size"] == 0

    def test_xml_file_extraction(self):
        """Testa extração de texto de arquivo XML."""
        # Arrange
        xml_content = '<?xml version="1.0"?><root><item>Texto XML</item></root>'
        file_content = xml_content.encode('utf-8')
        
        # Act
        result = extract_text_from_file(file_content, "xml")
        
        # Assert
        assert result["success"] is True
        assert "Texto XML" in result["extracted_text"]


class TestFileFormats:
    """Testes específicos para formatos de arquivo."""

    @pytest.mark.parametrize("file_format", SUPPORTED_FORMATS)
    def test_all_supported_formats_in_list(self, file_format):
        """Testa se todos os formatos suportados são válidos."""
        assert isinstance(file_format, str)
        assert len(file_format) > 0
        assert file_format.isupper()  # Formatos devem estar em maiúsculo

    def test_case_insensitive_format_handling(self):
        """Testa se o tratamento de formato é case-insensitive."""
        # Arrange
        text_content = "Teste de case sensitivity"
        file_content = text_content.encode('utf-8')
        
        # Act
        result_upper = extract_text_from_file(file_content, "TXT")
        result_lower = extract_text_from_file(file_content, "txt")
        result_mixed = extract_text_from_file(file_content, "Txt")
        
        # Assert
        assert result_upper["success"] is True
        assert result_lower["success"] is True
        assert result_mixed["success"] is True
        assert result_upper["extracted_text"] == result_lower["extracted_text"]
        assert result_lower["extracted_text"] == result_mixed["extracted_text"]


if __name__ == "__main__":
    pytest.main([__file__])