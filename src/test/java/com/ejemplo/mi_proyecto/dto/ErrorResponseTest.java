package com.ejemplo.mi_proyecto.dto;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.*;

class ErrorResponseTest {

    private LocalDateTime testTimestamp;

    @BeforeEach
    void setUp() {
        testTimestamp = LocalDateTime.now();
    }

    @Test
    void testConstructorWithAllParameters() {
        // When
        ErrorResponse response = new ErrorResponse(400, "BAD_REQUEST", "Datos inválidos", "/api/usuarios");

        // Then
        assertThat(response.getStatus()).isEqualTo(400);
        assertThat(response.getError()).isEqualTo("BAD_REQUEST");
        assertThat(response.getMessage()).isEqualTo("Datos inválidos");
        assertThat(response.getPath()).isEqualTo("/api/usuarios");
        assertThat(response.getTimestamp()).isNotNull();
    }

    @Test
    void testDefaultConstructor() {
        // When
        ErrorResponse response = new ErrorResponse();

        // Then
        assertThat(response.getStatus()).isZero();
        assertThat(response.getError()).isNull();
        assertThat(response.getMessage()).isNull();
        assertThat(response.getPath()).isNull();
        assertThat(response.getTimestamp()).isNotNull();
    }

    @Test
    void testSetterAndGetterMethods() {
        // Given
        ErrorResponse response = new ErrorResponse();

        // When
        response.setStatus(500);
        response.setError("INTERNAL_SERVER_ERROR");
        response.setMessage("Error interno del servidor");
        response.setPath("/api/usuarios");
        response.setTimestamp(testTimestamp);

        // Then
        assertThat(response.getStatus()).isEqualTo(500);
        assertThat(response.getError()).isEqualTo("INTERNAL_SERVER_ERROR");
        assertThat(response.getMessage()).isEqualTo("Error interno del servidor");
        assertThat(response.getPath()).isEqualTo("/api/usuarios");
        assertThat(response.getTimestamp()).isEqualTo(testTimestamp);
    }

    @Test
    void testTimestampIsSetAutomatically() {
        // Given
        LocalDateTime beforeCreation = LocalDateTime.now();

        // When
        ErrorResponse response = new ErrorResponse(409, "CONFLICT", "Conflicto de datos", "/api/usuarios");

        // Then
        LocalDateTime afterCreation = LocalDateTime.now();
        assertThat(response.getTimestamp()).isNotNull();
        assertThat(response.getTimestamp()).isAfterOrEqualTo(beforeCreation);
        assertThat(response.getTimestamp()).isBeforeOrEqualTo(afterCreation);
    }

    @Test
    void testBuilderPattern() {
        // When
        ErrorResponse response = new ErrorResponse();
        response.setStatus(422);
        response.setError("UNPROCESSABLE_ENTITY");
        response.setMessage("Entidad no procesable");
        response.setPath("/api/usuarios/validate");

        // Then
        assertThat(response.getStatus()).isEqualTo(422);
        assertThat(response.getError()).isEqualTo("UNPROCESSABLE_ENTITY");
        assertThat(response.getMessage()).isEqualTo("Entidad no procesable");
        assertThat(response.getPath()).isEqualTo("/api/usuarios/validate");
        assertThat(response.getTimestamp()).isNotNull();
    }
}