package student.base.env;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Service
public class SessionHandler extends HandlerInterceptorAdapter {
	protected final Log	logger	= LogFactory.getLog( getClass() );
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		String uri = request.getRequestURI().toString();
		
		//학생접속
		if(uri != null && uri.indexOf("/stud/") > -1) {
			if(session == null) {
				String contextPath = request.getContextPath();
				response.sendRedirect(contextPath+"/login/slogin.do");
				return false;
			} else {
				//학생접속일경우 stud세션이 없으면 로그인 페이지로 이동
				if(session.getAttribute("stud") == null) {
					if(uri != null && uri.indexOf("/stud/day_list.do") < 0) {
						String contextPath = request.getContextPath();
						response.sendRedirect(contextPath+"/login/slogin.do");
						return false;
					}
				}
			}
		}
		
		
		//관리자접속
		if(uri != null && uri.indexOf("/admin/") > -1) {
			if(session == null) {
				String contextPath = request.getContextPath();
				response.sendRedirect(contextPath+"/login/alogin.do");
				return false;
			} else {
				//관리자일경우 admin세션이 없으면 로그인 페이지로 이동
				if(session.getAttribute("admin") == null) {
					String contextPath = request.getContextPath();
					response.sendRedirect(contextPath+"/login/alogin.do");
					return false;
				}
			}
		}
		return true;
	}
}
