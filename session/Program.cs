namespace session
{
    internal class Program
    {
        static void Main(string[] args)

        
        {
            Controller controller = new Controller();
            for (int i = 0 ; i<3 ; i++)
            {
                Student student = new Student();
                Console.Write("enter the student name :");
                student.Name = Console.ReadLine();
                Console.Write("enter the student phone number:");
                student.Phone_No = int.Parse(Console.ReadLine());
                Console.Write("enter the student Address:");
                student.Address = Console.ReadLine();

                controller.AddStudent(student);


                



            }

            {
                foreach (Student st in controller.Students)
                {
                Console.WriteLine(st.Name);
                Console.WriteLine(st.Phone_No);
                Console.WriteLine(st.Address);
                }
            }
        }
    }
}
