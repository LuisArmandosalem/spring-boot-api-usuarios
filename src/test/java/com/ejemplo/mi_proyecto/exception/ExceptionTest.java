package com.ejemplo.mi_proyecto.exception;

import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.*;

class ExceptionTest {

    @Test
    void testResourceNotFoundException() {
        // Given
        String message = "Usuario no encontrado";
        
        // When
        ResourceNotFoundException exception = new ResourceNotFoundException(message);
        
        // Then
        assertThat(exception.getMessage()).isEqualTo(message);
        assertThat(exception).isInstanceOf(RuntimeException.class);
    }

    @Test
    void testDataConflictException() {
        // Given
        String message = "Email duplicado";
        
        // When
        DataConflictException exception = new DataConflictException(message);
        
        // Then
        assertThat(exception.getMessage()).isEqualTo(message);
        assertThat(exception).isInstanceOf(RuntimeException.class);
    }

    @Test
    void testResourceNotFoundExceptionWithCause() {
        // Given
        String message = "Usuario no encontrado";
        Throwable cause = new IllegalArgumentException("ID inválido");
        
        // When
        ResourceNotFoundException exception = new ResourceNotFoundException(message, cause);
        
        // Then
        assertThat(exception.getMessage()).isEqualTo(message);
        assertThat(exception.getCause()).isEqualTo(cause);
    }

    @Test
    void testDataConflictExceptionWithCause() {
        // Given
        String message = "Email duplicado";
        Throwable cause = new IllegalStateException("Constraint violation");
        
        // When
        DataConflictException exception = new DataConflictException(message, cause);
        
        // Then
        assertThat(exception.getMessage()).isEqualTo(message);
        assertThat(exception.getCause()).isEqualTo(cause);
    }
}