namespace Democracy.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class _20171026 : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.States", "Descripcion", c => c.String(nullable: false));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.States", "Descripcion", c => c.String());
        }
    }
}
