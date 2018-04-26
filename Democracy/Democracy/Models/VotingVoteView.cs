using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace Democracy.Models
{
    public class VotingVoteView : Voting
    {
        [NotMapped]
        public List<Candidate> MyCandidates { get; set; }
    }
}