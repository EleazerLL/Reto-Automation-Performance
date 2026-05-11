package com.curso.services;

import java.util.Collection;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.curso.model.Producto;

@RestController
@RequestMapping("/mercado")
public class ProductosRest {

	private final AtomicInteger counter = new AtomicInteger();
	private final Map<Integer, Producto> productos = new ConcurrentHashMap<>();

	@GetMapping
	public Collection<Producto> list() {
		return productos.values();
	}

	@GetMapping("/{id}")
	public Producto get(@PathVariable int id) {
		return productos.get(id);
	}

	@PostMapping
	public Producto create(@RequestBody Producto producto) {
		int id = counter.incrementAndGet();
		producto.setId(id);
		productos.put(id, producto);
		return producto;
	}

	@PutMapping("/{id}")
	public Producto put(@PathVariable int id, @RequestBody Producto producto) {
		productos.put(id, producto);
		return producto;
	}

	@DeleteMapping("/{id}")
	public void delete(@PathVariable int id) {
		Producto p = productos.remove(id);
		if (p == null) {
			throw new RuntimeException("Producto no encontrado con id: " + id);
		}
	}

	@DeleteMapping
	public void deleteWithBody(@RequestBody Producto producto) {
		delete(producto.getId());
	}

}
