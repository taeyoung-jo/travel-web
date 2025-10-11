package com.travelers.travelweb.global.util.auth;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.travelers.travelweb.domain.user.domain.User;
import com.travelers.travelweb.global.util.PhoneUtil;

public class PasswordUtil {
	public static String hash(String password) {
		return BCrypt.hashpw(password, BCrypt.gensalt());
	}

	public static boolean check(String password, String hash) {
		return BCrypt.checkpw(password, hash);
	}
}