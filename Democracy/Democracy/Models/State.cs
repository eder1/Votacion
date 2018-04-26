using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Democracy.Models
{
    public class State
    {
        [Key]
        public int StateId { get; set; }

        [Required(ErrorMessage ="The field {0} is required")]
        [StringLength(40, ErrorMessage ="The field {0} can contain maximun {1} and minimum {2} character",MinimumLength =3)]
        [Display(Name ="Description state")]
        public string Descripcion { get; set; }

        public virtual ICollection<Voting> Voltings { get; set; }
    }
}