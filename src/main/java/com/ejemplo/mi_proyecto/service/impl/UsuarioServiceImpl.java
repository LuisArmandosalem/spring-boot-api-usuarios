package com.ejemplo.mi_proyecto.service.impl;

import com.ejemplo.mi_proyecto.entity.Usuario;
import com.ejemplo.mi_proyecto.exception.DataConflictException;
import com.ejemplo.mi_proyecto.exception.ResourceNotFoundException;
import com.ejemplo.mi_proyecto.repository.UsuarioRepository;
import com.ejemplo.mi_proyecto.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Implementación del servicio de usuarios
 * Contiene toda la lógica de negocio relacionada con usuarios
 */
@Service
@Transactional
public class UsuarioServiceImpl implements UsuarioService {

    private final UsuarioRepository usuarioRepository;

    @Autowired
    public UsuarioServiceImpl(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Usuario> obtenerTodosLosUsuarios() {
        return usuarioRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Usuario> obtenerUsuarioPorId(Long id) {
        if (id == null || id <= 0) {
            throw new IllegalArgumentException("El ID del usuario debe ser un número positivo");
        }
        return usuarioRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Usuario> obtenerUsuarioPorEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            throw new IllegalArgumentException("El email no puede estar vacío");
        }
        return usuarioRepository.findByEmail(email.trim().toLowerCase());
    }

    @Override
    public Usuario crearUsuario(Usuario usuario) {
        // Validaciones de negocio
        validarUsuario(usuario);
        
        // Normalizar email
        usuario.setEmail(usuario.getEmail().trim().toLowerCase());
        
        // Verificar que el email no exista
        if (usuarioRepository.existsByEmail(usuario.getEmail())) {
            throw new DataConflictException("Ya existe un usuario con el email: " + usuario.getEmail());
        }
        
        // Normalizar nombre
        if (usuario.getNombre() != null) {
            usuario.setNombre(usuario.getNombre().trim());
        }
        
        // Guardar usuario
        return usuarioRepository.save(usuario);
    }

    @Override
    public Usuario actualizarUsuario(Long id, Usuario usuarioActualizado) {
        // Validar ID
        if (id == null || id <= 0) {
            throw new IllegalArgumentException("El ID del usuario debe ser un número positivo");
        }
        
        // Buscar usuario existente
        Usuario usuarioExistente = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado con ID: " + id));
        
        // Validar datos del usuario actualizado
        validarUsuario(usuarioActualizado);
        
        // Normalizar email
        String emailNormalizado = usuarioActualizado.getEmail().trim().toLowerCase();
        
        // Verificar email único (solo si cambió)
        if (!usuarioExistente.getEmail().equals(emailNormalizado)) {
            if (usuarioRepository.existsByEmail(emailNormalizado)) {
                throw new DataConflictException("Ya existe un usuario con el email: " + emailNormalizado);
            }
        }
        
        // Actualizar campos
        usuarioExistente.setNombre(usuarioActualizado.getNombre().trim());
        usuarioExistente.setEmail(emailNormalizado);
        usuarioExistente.setTelefono(usuarioActualizado.getTelefono());
        
        return usuarioRepository.save(usuarioExistente);
    }

    @Override
    public void eliminarUsuario(Long id) {
        // Validar ID
        if (id == null || id <= 0) {
            throw new IllegalArgumentException("El ID del usuario debe ser un número positivo");
        }
        
        // Verificar que el usuario exista
        if (!usuarioRepository.existsById(id)) {
            throw new ResourceNotFoundException("Usuario no encontrado con ID: " + id);
        }
        
        // Eliminar usuario
        usuarioRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existeUsuarioConEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return usuarioRepository.existsByEmail(email.trim().toLowerCase());
    }

    /**
     * Valida los datos básicos de un usuario
     * @param usuario Usuario a validar
     * @throws IllegalArgumentException si los datos no son válidos
     */
    private void validarUsuario(Usuario usuario) {
        if (usuario == null) {
            throw new IllegalArgumentException("El usuario no puede ser null");
        }
        
        if (usuario.getNombre() == null || usuario.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del usuario es obligatorio");
        }
        
        if (usuario.getEmail() == null || usuario.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("El email del usuario es obligatorio");
        }
        
        // Validación básica de email
        String email = usuario.getEmail().trim();
        if (!email.contains("@") || !email.contains(".")) {
            throw new IllegalArgumentException("El formato del email no es válido");
        }
        
        // Validar longitud del nombre
        if (usuario.getNombre().trim().length() < 2) {
            throw new IllegalArgumentException("El nombre debe tener al menos 2 caracteres");
        }
        
        if (usuario.getNombre().trim().length() > 100) {
            throw new IllegalArgumentException("El nombre no puede tener más de 100 caracteres");
        }
    }
}