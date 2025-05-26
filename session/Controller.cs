using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace session
{
    internal class Controller
    {
       public List<Student> Students = new List<Student>();
       public void AddStudent(Student st)
        {

        Students.Add(st); 
        }

    }
}
