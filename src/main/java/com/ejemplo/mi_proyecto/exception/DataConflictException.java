package com.ejemplo.mi_proyecto.exception;

/**
 * Excepción lanzada cuando hay un conflicto en los datos (ej: email duplicado)
 */
public class DataConflictException extends RuntimeException {
    
    public DataConflictException(String message) {
        super(message);
    }
    
    public DataConflictException(String message, Throwable cause) {
        super(message, cause);
    }
}