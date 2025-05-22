package com.roomease.filter;

import java.io.IOException;

import com.roomease.util.SessionUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(asyncSupported = true, urlPatterns = { "/*" })
public class AuthenticationFilter implements Filter {

	private static final String LOGIN = "/login";
	private static final String REGISTER = "/register";
	private static final String HOME = "/home";
	private static final String ROOT = "/";

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		Filter.super.init(filterConfig);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		// 💡 Add no-cache headers to prevent browser from caching protected pages
		res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0
		res.setDateHeader("Expires", 0); // Proxies

		String uri = req.getRequestURI();

		// Allow CSS and root (optional), but not /home
		if (uri.endsWith(".css") || uri.endsWith(ROOT)) {
		    chain.doFilter(request, response);
		    return;
		}


		boolean isLoggedIn = SessionUtil.getAttribute(req, "user_name") != null;

		if (!isLoggedIn) {
			if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
				chain.doFilter(request, response);
			} else {
				res.sendRedirect(req.getContextPath() + LOGIN);
			}
		} else {
			if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
				res.sendRedirect(req.getContextPath() + HOME);
			} else {
				chain.doFilter(request, response);
			}
		}
	}

	@Override
	public void destroy() {
		Filter.super.destroy();
	}
}
