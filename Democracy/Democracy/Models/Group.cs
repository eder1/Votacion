using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Democracy.Models
{
    public class Group
    {
        [Key]
        public int GroupId { get; set; }

        [Required(ErrorMessage = "The field {0} is required")]
        [StringLength(40, ErrorMessage = "The field {0} can contain maximun {1} and minimum {2} character", MinimumLength = 3)]
        public string Descripcion { get; set; }

        public virtual ICollection<GroupMember> GroupMember { get; set; }
        public virtual ICollection<VotingGroup> VotingGroup { get; set; }
    }

}