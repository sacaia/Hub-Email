import util.GerenciadorEmail;

public class Testes {

	public static void main(String[] args) {
		GerenciadorEmail ge = new GerenciadorEmail("MedicosOnlinePR3@gmail.com", "PR317178");
		
		String[] dest = new String[10];
		dest[0] = "cc17189@g.unicamp.br";
		
		try {
			ge.setSenderSession("465", "smtp.fastmail.com");
			
			ge.enviarEmail("assunto muito interesante", "um texto ai", null, dest, null, null);
			
			System.out.println("foi");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("n foi");
		}
	}
}
