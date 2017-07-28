/**
 *
 */
package com.naver.jihyunboard.user.model;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

/**
 * @author NAVER
 *
 */
@Data
public class UserDetailsImpl extends User {

	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;

	private String userName;

	public UserDetailsImpl(BoardUser user, Collection<? extends GrantedAuthority> authorities) {
		super(Integer.toString(user.getUserId()), user.getUserPw(), authorities);
		this.userName = user.getUserName();
	}

}
