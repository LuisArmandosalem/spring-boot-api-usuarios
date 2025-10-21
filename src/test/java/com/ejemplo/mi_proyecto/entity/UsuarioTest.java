package com.ejemplo.mi_proyecto.entity;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.assertj.core.api.Assertions.*;

class UsuarioTest {

    private Usuario usuario;

    @BeforeEach
    void setUp() {
        usuario = new Usuario();
    }

    @Test
    void testConstructorVacio() {
        // Given & When
        Usuario nuevoUsuario = new Usuario();
        
        // Then
        assertThat(nuevoUsuario.getId()).isNull();
        assertThat(nuevoUsuario.getNombre()).isNull();
        assertThat(nuevoUsuario.getEmail()).isNull();
        assertThat(nuevoUsuario.getTelefono()).isNull();
    }

    @Test
    void testConstructorConParametros() {
        // Given
        String nombre = "Juan Pérez";
        String email = "juan@example.com";
        String telefono = "555-1234";
        
        // When
        Usuario nuevoUsuario = new Usuario(nombre, email, telefono);
        
        // Then
        assertThat(nuevoUsuario.getNombre()).isEqualTo(nombre);
        assertThat(nuevoUsuario.getEmail()).isEqualTo(email);
        assertThat(nuevoUsuario.getTelefono()).isEqualTo(telefono);
        assertThat(nuevoUsuario.getId()).isNull(); // ID se asigna por la base de datos
    }

    @Test
    void testSettersYGetters() {
        // Given
        Long id = 1L;
        String nombre = "María García";
        String email = "maria@example.com";
        String telefono = "555-5678";
        
        // When
        usuario.setId(id);
        usuario.setNombre(nombre);
        usuario.setEmail(email);
        usuario.setTelefono(telefono);
        
        // Then
        assertThat(usuario.getId()).isEqualTo(id);
        assertThat(usuario.getNombre()).isEqualTo(nombre);
        assertThat(usuario.getEmail()).isEqualTo(email);
        assertThat(usuario.getTelefono()).isEqualTo(telefono);
    }

    @Test
    void testEqualsYHashCode() {
        // Given
        Usuario usuario1 = new Usuario("Test", "test@example.com", "123");
        usuario1.setId(1L);
        
        Usuario usuario2 = new Usuario("Test", "test@example.com", "123");
        usuario2.setId(1L);
        
        Usuario usuario3 = new Usuario("Other", "other@example.com", "456");
        usuario3.setId(2L);
        
        // Then
        assertThat(usuario1)
            .isEqualTo(usuario2)
            .isNotEqualTo(usuario3)
            .hasSameHashCodeAs(usuario2);
    }

    @Test
    void testToString() {
        // Given
        usuario.setId(1L);
        usuario.setNombre("Test User");
        usuario.setEmail("test@example.com");
        usuario.setTelefono("555-0000");
        
        // When
        String toString = usuario.toString();
        
        // Then
        assertThat(toString)
            .contains("Test User")
            .contains("test@example.com")
            .contains("555-0000");
    }

    @Test
    void testValidacionEmail() {
        // Given & When
        usuario.setEmail("email-valido@example.com");
        
        // Then
        assertThat(usuario.getEmail()).isEqualTo("email-valido@example.com");
    }

    @Test
    void testCamposVacios() {
        // Given & When
        usuario.setNombre("");
        usuario.setEmail("");
        usuario.setTelefono("");
        
        // Then
        assertThat(usuario.getNombre()).isEmpty();
        assertThat(usuario.getEmail()).isEmpty();
        assertThat(usuario.getTelefono()).isEmpty();
    }
}