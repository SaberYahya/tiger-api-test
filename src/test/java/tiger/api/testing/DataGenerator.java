package tiger.api.testing;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.github.javafaker.Faker;

public class DataGenerator {

	public static String getEmail() {
		Faker faker = new Faker();
		return faker.name().firstName() + faker.name().lastName()+ "@gmail.com";
	}
	
	public static String getPhoneNumber() {
		Faker faker = new Faker();
		return faker.phoneNumber().cellPhone();
	}
	
	public static String getFirstName() {
		Faker faker = new Faker();
		return faker.name().firstName();
	}
	
	public static String getLastName() {
		Faker faker = new Faker();
		return faker.name().lastName();
	}
	
	public static String getDob() {
		Faker faker = new Faker();
		Date date = faker.date().birthday();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(date);
	}
	
	
	
	
	
	
	
	
}
