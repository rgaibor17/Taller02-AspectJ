
 

	import com.bettinghouse.Person;
	import com.bettinghouse.User;
	import java.io.File;
	import java.io.FileNotFoundException;
	import java.io.FileOutputStream;
	import java.io.PrintWriter;
	import java.util.Calendar;
	/*import com.bettinghouse.Person;
	import com.bettinghouse.User;*/

	public aspect Logger {
	
	
	File file = new File("Register.txt");
	File file2 = new File("Log.txt");
	    Calendar cal;
	    User user;
	    
	    
	pointcut registrarUsuario(User user, Person person): call(* successfulSignUp(User, Person)) && args(user, person);
	    
	    after(User user, Person person) : registrarUsuario(user, person) {
	    this.cal = Calendar.getInstance();
	    try(PrintWriter pw=new PrintWriter(new FileOutputStream(file,true))){
	    pw.println("Usuario registrado: ["+user.toString()+"]    Fecha: ["+cal.getTime() + "]");
	    System.out.println("****Usuario ["+user.getNickname()+"] Registrado**** "+cal.getTime());
	    }catch(FileNotFoundException e){System.out.println(e.getMessage());}    
	    }
	
	pointcut iniciarSesionUsuario(User user): call(* effectiveLogIn(User)) && args(user);
	    
	    after(User user) : iniciarSesionUsuario(user) {
	    this.cal = Calendar.getInstance();
	    try(PrintWriter pw=new PrintWriter(new FileOutputStream(file2,true))){
	    pw.println("Sesión iniciada por usuario: ["+user.getNickname()+"]    Fecha: ["+cal.getTime() + "]");
	    System.out.println("Sesión iniciada por usuario: ["+user.getNickname()+"]    Fecha: ["+cal.getTime() + "]");
	    }catch(FileNotFoundException e){System.out.println(e.getMessage());}    
	    }
	    
    	pointcut cerrarSesionUsuario(User user): call(* effectiveLogOut(User)) && args(user);
	    
	    after(User user) : cerrarSesionUsuario(user) {
	    this.cal = Calendar.getInstance();
	    try(PrintWriter pw=new PrintWriter(new FileOutputStream(file2,true))){
	    pw.println("Sesión cerrada por usuario: ["+user.getNickname()+"]    Fecha: ["+cal.getTime() + "]");
	    System.out.println("Sesión cerrada por usuario: ["+user.getNickname()+"]    Fecha: ["+cal.getTime() + "]");
	    }catch(FileNotFoundException e){System.out.println(e.getMessage());}    
	    }
}


