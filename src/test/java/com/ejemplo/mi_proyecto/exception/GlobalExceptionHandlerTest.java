package com.ejemplo.mi_proyecto.exception;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.context.request.WebRequest;
import com.ejemplo.mi_proyecto.dto.ErrorResponse;

class GlobalExceptionHandlerTest {

    private GlobalExceptionHandler exceptionHandler;
    private WebRequest webRequest;

    @BeforeEach
    void setUp() {
        exceptionHandler = new GlobalExceptionHandler();
        webRequest = mock(WebRequest.class);
    }

    @Test
    void handleResourceNotFoundException() {
        // Given
        String message = "Usuario no encontrado";
        ResourceNotFoundException exception = new ResourceNotFoundException(message);
        when(webRequest.getDescription(false)).thenReturn("uri=/api/usuarios/1");

        // When
        ResponseEntity<ErrorResponse> response = exceptionHandler
                .handleResourceNotFoundException(exception, webRequest);

        // Then
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getStatus()).isEqualTo(404);
        assertThat(response.getBody().getError()).isEqualTo("NOT_FOUND");
        assertThat(response.getBody().getMessage()).isEqualTo(message);
        assertThat(response.getBody().getPath()).isEqualTo("/api/usuarios/1");
    }

    @Test
    void handleDataConflictException() {
        // Given
        String message = "Email ya existe";
        DataConflictException exception = new DataConflictException(message);
        when(webRequest.getDescription(false)).thenReturn("uri=/api/usuarios");

        // When
        ResponseEntity<ErrorResponse> response = exceptionHandler
                .handleDataConflictException(exception, webRequest);

        // Then
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getStatus()).isEqualTo(409);
        assertThat(response.getBody().getError()).isEqualTo("CONFLICT");
        assertThat(response.getBody().getMessage()).isEqualTo(message);
        assertThat(response.getBody().getPath()).isEqualTo("/api/usuarios");
    }

    @Test
    void handleIllegalArgumentException() {
        // Given
        String message = "ID inválido";
        IllegalArgumentException exception = new IllegalArgumentException(message);
        when(webRequest.getDescription(false)).thenReturn("uri=/api/usuarios/-1");

        // When
        ResponseEntity<ErrorResponse> response = exceptionHandler
                .handleIllegalArgumentException(exception, webRequest);

        // Then
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getStatus()).isEqualTo(400);
        assertThat(response.getBody().getError()).isEqualTo("Invalid Request");
        assertThat(response.getBody().getMessage()).isEqualTo(message);
        assertThat(response.getBody().getPath()).isEqualTo("/api/usuarios/-1");
    }

    @Test
    void handleGenericException() {
        // Given
        String message = "Error inesperado";
        RuntimeException exception = new RuntimeException(message);
        when(webRequest.getDescription(false)).thenReturn("uri=/api/usuarios");

        // When
        ResponseEntity<ErrorResponse> response = exceptionHandler
                .handleGenericException(exception, webRequest);

        // Then
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getStatus()).isEqualTo(500);
        assertThat(response.getBody().getError()).isEqualTo("Internal Server Error");
        assertThat(response.getBody().getMessage())
                .isEqualTo("Ha ocurrido un error interno. Por favor contacte al administrador.");
        assertThat(response.getBody().getPath()).isEqualTo("/api/usuarios");
    }

    @Test
    void testPathProcessingWithoutUri() {
        // Given
        ResourceNotFoundException exception = new ResourceNotFoundException("Test");
        when(webRequest.getDescription(false)).thenReturn("/api/usuarios/123");

        // When
        ResponseEntity<ErrorResponse> response = exceptionHandler
                .handleResourceNotFoundException(exception, webRequest);

        // Then
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getPath()).isEqualTo("/api/usuarios/123");
    }
}
