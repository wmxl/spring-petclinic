package org.springframework.samples.petclinic.system;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;


@ConfigurationProperties(prefix = "person")
@Component
public class Person {

	private String name;
	private int age;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	@Override
	public String toString() {
		return "Person{" +
			"name='" + name + '\'' +
			", age=" + age +
			'}';
	}
}
