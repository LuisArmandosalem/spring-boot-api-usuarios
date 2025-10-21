package com.ejemplo.mi_proyecto.repository;

import com.ejemplo.mi_proyecto.entity.Usuario;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;

@DataJpaTest
@ActiveProfiles("test")
class UsuarioRepositoryTest {

    @Autowired
    private UsuarioRepository usuarioRepository;

    private Usuario usuarioTest;

    @BeforeEach
    void setUp() {
        usuarioTest = new Usuario("Test User", "test@example.com", "555-1234");
    }

    @Test
    void testSave() {
        // When
        Usuario savedUsuario = usuarioRepository.save(usuarioTest);
        
        // Then
        assertThat(savedUsuario).isNotNull();
        assertThat(savedUsuario.getId()).isNotNull();
        assertThat(savedUsuario.getNombre()).isEqualTo("Test User");
        assertThat(savedUsuario.getEmail()).isEqualTo("test@example.com");
    }

    @Test
    void testFindById() {
        // Given
        Usuario savedUsuario = usuarioRepository.save(usuarioTest);
        
        // When
        Optional<Usuario> foundUsuario = usuarioRepository.findById(savedUsuario.getId());
        
        // Then
        assertThat(foundUsuario).isPresent();
        assertThat(foundUsuario.get().getNombre()).isEqualTo("Test User");
    }

    @Test
    void testFindByIdNotFound() {
        // When
        Optional<Usuario> foundUsuario = usuarioRepository.findById(999L);
        
        // Then
        assertThat(foundUsuario).isNotPresent();
    }

    @Test
    void testFindByEmail() {
        // Given
        usuarioRepository.save(usuarioTest);
        
        // When
        Optional<Usuario> foundUsuario = usuarioRepository.findByEmail("test@example.com");
        
        // Then
        assertThat(foundUsuario).isPresent();
        assertThat(foundUsuario.get().getNombre()).isEqualTo("Test User");
    }

    @Test
    void testFindByEmailNotFound() {
        // When
        Optional<Usuario> foundUsuario = usuarioRepository.findByEmail("notfound@example.com");
        
        // Then
        assertThat(foundUsuario).isNotPresent();
    }

    @Test
    void testExistsByEmail() {
        // Given
        usuarioRepository.save(usuarioTest);
        
        // When
        boolean exists = usuarioRepository.existsByEmail("test@example.com");
        boolean notExists = usuarioRepository.existsByEmail("notfound@example.com");
        
        // Then
        assertThat(exists).isTrue();
        assertThat(notExists).isFalse();
    }

    @Test
    void testFindAll() {
        // Given
        Usuario usuario1 = new Usuario("User 1", "user1@example.com", "111-1111");
        Usuario usuario2 = new Usuario("User 2", "user2@example.com", "222-2222");
        usuarioRepository.save(usuario1);
        usuarioRepository.save(usuario2);
        
        // When
        List<Usuario> usuarios = usuarioRepository.findAll();
        
        // Then
        assertThat(usuarios).hasSize(2);
        assertThat(usuarios).extracting(Usuario::getEmail)
            .contains("user1@example.com", "user2@example.com");
    }

    @Test
    void testDeleteById() {
        // Given
        Usuario savedUsuario = usuarioRepository.save(usuarioTest);
        Long id = savedUsuario.getId();
        
        // When
        usuarioRepository.deleteById(id);
        
        // Then
        Optional<Usuario> deletedUsuario = usuarioRepository.findById(id);
        assertThat(deletedUsuario).isNotPresent();
    }

    @Test
    void testUpdate() {
        // Given
        Usuario savedUsuario = usuarioRepository.save(usuarioTest);
        
        // When
        savedUsuario.setNombre("Updated Name");
        savedUsuario.setTelefono("999-9999");
        Usuario updatedUsuario = usuarioRepository.save(savedUsuario);
        
        // Then
        assertThat(updatedUsuario.getNombre()).isEqualTo("Updated Name");
        assertThat(updatedUsuario.getTelefono()).isEqualTo("999-9999");
        assertThat(updatedUsuario.getEmail()).isEqualTo("test@example.com"); // Email no cambia
    }

    @Test
    void testEmailUniqueConstraint() {
        // Given
        Usuario usuario1 = new Usuario("User 1", "duplicate@example.com", "111-1111");
        Usuario usuario2 = new Usuario("User 2", "duplicate@example.com", "222-2222");
        
        usuarioRepository.save(usuario1);
        
        // When & Then
        assertThatThrownBy(() -> {
            usuarioRepository.save(usuario2);
            usuarioRepository.flush(); // Forzar la escritura a DB
        }).isInstanceOf(Exception.class);
    }
}