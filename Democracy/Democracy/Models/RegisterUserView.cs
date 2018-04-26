using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Democracy.Models
{
    public class RegisterUserView : UserView
    {

        [Required(ErrorMessage = "The field {0} is required")]
        [StringLength(20, ErrorMessage =
          "The field {0} can contain maximun {1} and minimum {2} character", MinimumLength = 8)]
        [Display(Name = "Password")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required(ErrorMessage = "The field {0} is required")]
        [StringLength(20, ErrorMessage =
            "The field {0} can contain maximun {1} and minimum {2} character", MinimumLength = 8)]
        [Display(Name = "Confir password")]
        [DataType(DataType.Password)]
        [Compare("Password",ErrorMessage ="Password and confirm does not match")]
        public string ConfirPassword { get; set; }

    }
}