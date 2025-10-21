package com.ejemplo.mi_proyecto.repository;

import com.ejemplo.mi_proyecto.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    
    // Método personalizado para buscar por email
    Optional<Usuario> findByEmail(String email);
    
    // Método personalizado para verificar si existe un email
    boolean existsByEmail(String email);
}