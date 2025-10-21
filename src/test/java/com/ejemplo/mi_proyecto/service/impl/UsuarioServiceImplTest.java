package com.ejemplo.mi_proyecto.service.impl;

import com.ejemplo.mi_proyecto.entity.Usuario;
import com.ejemplo.mi_proyecto.exception.DataConflictException;
import com.ejemplo.mi_proyecto.exception.ResourceNotFoundException;
import com.ejemplo.mi_proyecto.repository.UsuarioRepository;
import com.ejemplo.mi_proyecto.service.UsuarioService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UsuarioServiceImplTest {

    @Mock
    private UsuarioRepository usuarioRepository;

    @InjectMocks
    private UsuarioServiceImpl usuarioServiceImpl;
    
    private UsuarioService usuarioService;

    private Usuario usuarioTest;

    @BeforeEach
    void setUp() {
        usuarioService = usuarioServiceImpl;
        usuarioTest = new Usuario("Test User", "test@example.com", "555-1234");
        usuarioTest.setId(1L);
    }

    @Test
    void testObtenerTodosLosUsuarios() {
        // Given
        Usuario usuario1 = new Usuario("User 1", "user1@example.com", "111-1111");
        Usuario usuario2 = new Usuario("User 2", "user2@example.com", "222-2222");
        List<Usuario> usuarios = Arrays.asList(usuario1, usuario2);
        
        when(usuarioRepository.findAll()).thenReturn(usuarios);
        
        // When
        List<Usuario> result = usuarioService.obtenerTodosLosUsuarios();
        
        // Then
        assertThat(result)
            .hasSize(2)
            .containsExactly(usuario1, usuario2);
        verify(usuarioRepository).findAll();
    }

    @Test
    void testObtenerUsuarioPorId() {
        // Given
        when(usuarioRepository.findById(1L)).thenReturn(Optional.of(usuarioTest));
        
        // When
        Optional<Usuario> result = usuarioService.obtenerUsuarioPorId(1L);
        
        // Then
        assertThat(result).contains(usuarioTest);
        verify(usuarioRepository).findById(1L);
    }

    @Test
    void testObtenerUsuarioPorIdNotFound() {
        // Given
        when(usuarioRepository.findById(999L)).thenReturn(Optional.empty());
        
        // When
        Optional<Usuario> result = usuarioService.obtenerUsuarioPorId(999L);
        
        // Then
        assertThat(result).isNotPresent();
        verify(usuarioRepository).findById(999L);
    }

    @Test
    void testCrearUsuario() {
        // Given
        Usuario usuarioNuevo = new Usuario("New User", "new@example.com", "555-5678");
        Usuario usuarioGuardado = new Usuario("New User", "new@example.com", "555-5678");
        usuarioGuardado.setId(2L);
        
        when(usuarioRepository.existsByEmail("new@example.com")).thenReturn(false);
        when(usuarioRepository.save(any(Usuario.class))).thenReturn(usuarioGuardado);
        
        // When
        Usuario result = usuarioService.crearUsuario(usuarioNuevo);
        
        // Then
        assertThat(result.getId()).isEqualTo(2L);
        assertThat(result.getEmail()).isEqualTo("new@example.com");
        verify(usuarioRepository).existsByEmail("new@example.com");
        verify(usuarioRepository).save(usuarioNuevo);
    }

    @Test
    void testCrearUsuarioEmailDuplicado() {
        // Given
        Usuario usuarioNuevo = new Usuario("New User", "existing@example.com", "555-5678");
        
        when(usuarioRepository.existsByEmail("existing@example.com")).thenReturn(true);
        
        // When & Then
        assertThatThrownBy(() -> usuarioService.crearUsuario(usuarioNuevo))
            .isInstanceOf(DataConflictException.class)
            .hasMessage("Ya existe un usuario con el email: existing@example.com");
        
        verify(usuarioRepository).existsByEmail("existing@example.com");
        verify(usuarioRepository, never()).save(any(Usuario.class));
    }

    @Test
    void testActualizarUsuario() {
        // Given
        Usuario usuarioActualizado = new Usuario("Updated User", "updated@example.com", "999-9999");
        usuarioActualizado.setId(1L);
        
        when(usuarioRepository.findById(1L)).thenReturn(Optional.of(usuarioTest));
        when(usuarioRepository.existsByEmail("updated@example.com")).thenReturn(false);
        when(usuarioRepository.save(any(Usuario.class))).thenReturn(usuarioActualizado);
        
        // When
        Usuario result = usuarioService.actualizarUsuario(1L, usuarioActualizado);
        
        // Then
        assertThat(result.getNombre()).isEqualTo("Updated User");
        assertThat(result.getEmail()).isEqualTo("updated@example.com");
        verify(usuarioRepository).findById(1L);
        verify(usuarioRepository).existsByEmail("updated@example.com");
        verify(usuarioRepository).save(any(Usuario.class));
    }

    @Test
    void testActualizarUsuarioNoExiste() {
        // Given
        Usuario usuarioActualizado = new Usuario("Updated User", "updated@example.com", "999-9999");
        
        when(usuarioRepository.findById(999L)).thenReturn(Optional.empty());
        
        // When & Then
        assertThatThrownBy(() -> usuarioService.actualizarUsuario(999L, usuarioActualizado))
            .isInstanceOf(ResourceNotFoundException.class)
            .hasMessage("Usuario no encontrado con ID: 999");
        
        verify(usuarioRepository).findById(999L);
        verify(usuarioRepository, never()).save(any(Usuario.class));
    }

    @Test
    void testEliminarUsuario() {
        // Given
        when(usuarioRepository.existsById(1L)).thenReturn(true);
        doNothing().when(usuarioRepository).deleteById(1L);
        
        // When
        usuarioService.eliminarUsuario(1L);
        
        // Then
        verify(usuarioRepository).existsById(1L);
        verify(usuarioRepository).deleteById(1L);
    }

    @Test
    void testEliminarUsuarioNotFound() {
        // Given
        when(usuarioRepository.existsById(999L)).thenReturn(false);
        
        // When & Then
        assertThatThrownBy(() -> usuarioService.eliminarUsuario(999L))
            .isInstanceOf(ResourceNotFoundException.class)
            .hasMessage("Usuario no encontrado con ID: 999");
        
        verify(usuarioRepository).existsById(999L);
        verify(usuarioRepository, never()).deleteById(anyLong());
    }

    @Test
    void testObtenerUsuarioPorEmail() {
        // Given
        when(usuarioRepository.findByEmail("test@example.com")).thenReturn(Optional.of(usuarioTest));
        
        // When
        Optional<Usuario> result = usuarioService.obtenerUsuarioPorEmail("test@example.com");
        
        // Then
        assertThat(result).contains(usuarioTest);
        verify(usuarioRepository).findByEmail("test@example.com");
    }

    @Test
    void testExisteUsuarioConEmail() {
        // Given
        when(usuarioRepository.existsByEmail("test@example.com")).thenReturn(true);
        when(usuarioRepository.existsByEmail("notfound@example.com")).thenReturn(false);
        
        // When
        boolean exists = usuarioService.existeUsuarioConEmail("test@example.com");
        boolean notExists = usuarioService.existeUsuarioConEmail("notfound@example.com");
        
        // Then
        assertThat(exists).isTrue();
        assertThat(notExists).isFalse();
        verify(usuarioRepository).existsByEmail("test@example.com");
        verify(usuarioRepository).existsByEmail("notfound@example.com");
    }
}