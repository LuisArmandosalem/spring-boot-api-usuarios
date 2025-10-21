package com.ejemplo.mi_proyecto.service;

import com.ejemplo.mi_proyecto.entity.Usuario;
import java.util.List;
import java.util.Optional;

/**
 * Interfaz del servicio de usuarios que define las operaciones de negocio
 */
public interface UsuarioService {
    
    /**
     * Obtiene todos los usuarios
     * @return Lista de todos los usuarios
     */
    List<Usuario> obtenerTodosLosUsuarios();
    
    /**
     * Busca un usuario por su ID
     * @param id ID del usuario
     * @return Usuario encontrado o empty si no existe
     */
    Optional<Usuario> obtenerUsuarioPorId(Long id);
    
    /**
     * Busca un usuario por su email
     * @param email Email del usuario
     * @return Usuario encontrado o empty si no existe
     */
    Optional<Usuario> obtenerUsuarioPorEmail(String email);
    
    /**
     * Crea un nuevo usuario
     * @param usuario Datos del usuario a crear
     * @return Usuario creado con ID asignado
     * @throws IllegalArgumentException si el email ya existe
     */
    Usuario crearUsuario(Usuario usuario);
    
    /**
     * Actualiza un usuario existente
     * @param id ID del usuario a actualizar
     * @param usuarioActualizado Nuevos datos del usuario
     * @return Usuario actualizado
     * @throws IllegalArgumentException si el usuario no existe
     */
    Usuario actualizarUsuario(Long id, Usuario usuarioActualizado);
    
    /**
     * Elimina un usuario por su ID
     * @param id ID del usuario a eliminar
     * @throws IllegalArgumentException si el usuario no existe
     */
    void eliminarUsuario(Long id);
    
    /**
     * Verifica si existe un usuario con el email dado
     * @param email Email a verificar
     * @return true si existe, false si no
     */
    boolean existeUsuarioConEmail(String email);
}