import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.T_T.model.Member;
import com.T_T.model.MemberDAO;

@WebServlet("/LoginCon")
public class LoginCon extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String pw = request.getParameter("pw");

        Member member = new Member(email, pw); // email과 pw만으로 Member 객체 생성

        Member login_member = new MemberDAO().login(member);	

        if (login_member != null) {
            // 로그인 성공
            System.out.println("로그인 성공!");
            HttpSession session = request.getSession();
            session.setAttribute("login_member", login_member);
        } else {
            // 로그인 실패
            System.out.println("로그인 실패..");
        }

        return "T_T_Main.jsp";
    }
}
