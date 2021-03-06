USE [master]
GO
/****** Object:  Database [Democracy]    Script Date: 02/11/2017 16:14:19 ******/
CREATE DATABASE [Democracy]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Democracy', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Democracy.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Democracy_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Democracy_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Democracy] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Democracy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Democracy] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Democracy] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Democracy] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Democracy] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Democracy] SET ARITHABORT OFF 
GO
ALTER DATABASE [Democracy] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Democracy] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Democracy] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Democracy] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Democracy] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Democracy] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Democracy] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Democracy] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Democracy] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Democracy] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Democracy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Democracy] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Democracy] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Democracy] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Democracy] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Democracy] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Democracy] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Democracy] SET RECOVERY FULL 
GO
ALTER DATABASE [Democracy] SET  MULTI_USER 
GO
ALTER DATABASE [Democracy] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Democracy] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Democracy] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Democracy] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Democracy] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Democracy', N'ON'
GO
USE [Democracy]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GroupMembers]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupMembers](
	[GroupMemberId] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.GroupMembers] PRIMARY KEY CLUSTERED 
(
	[GroupMemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Groups]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_dbo.Groups] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[States]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_dbo.States] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[Grade] [nvarchar](max) NULL,
	[Group] [nvarchar](max) NULL,
	[Photo] [nvarchar](200) NULL,
 CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Votings]    Script Date: 02/11/2017 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Votings](
	[VotingId] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](40) NOT NULL,
	[StateId] [int] NOT NULL,
	[Remarks] [nvarchar](max) NULL,
	[DateTimeStart] [datetime] NOT NULL,
	[DateTimeEnd] [datetime] NOT NULL,
	[IsForAllUsers] [bit] NOT NULL,
	[IsEnabledBlankVote] [bit] NOT NULL,
	[QuantityVotes] [int] NOT NULL,
	[QuantityBlankVotes] [int] NOT NULL,
	[CandidateWinId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Votings] PRIMARY KEY CLUSTERED 
(
	[VotingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201710270050045_InitialCreate', N'Democracy.Migrations.Configuration', 0x1F8B0800000000000400CD57C96E233710BD07C83F34784A008FE8E59218AD1938921D0819D9C6B467EE14BB2413E1D221D986F46D73C827E51752EC7D91648D3140025DD4642DAF5E6DDDFF7CFD3BFEB055327A01EB84D1537231392711686E52A1375392FBF5BB5FC887F73FFE10DFA66A1B7DA9E5AE821C6A6A3725CFDE67D7943AFE0C8AB98912DC1A67D67EC28DA22C35F4F2FCFC577A7141014D10B41545F1A75C7BA1A078C0C799D11C329F33B9342948579DE34D52588DEE990297310E53320765B8657C37296549742305431C09C8358998D6C6338F28AF3F3B48BC357A936478C0E4D32E03945B33E9A0427FDD8A9F1AC8F9650884B68AB5299E3B6FD4371ABCB8AA98A143F537F14B1AE690BB5BE4D8EF42D4057FC8105AC6C8879EAE67D206A931B79342E32C6ACECF9A12C04A09BFB368964B9F5B986AC8BD65F22C7ACC5752F03F60F764FE043DD5B9945D58080CEF7A0778F4684D06D6EF3EC1BA0B76919288F695E950BBD11D2A96312DB4BFBA24D13DC2602B094DFE3BF127DE58F81D3458D44C1F99F760317D8B140A064710060EE7E0B815192F92563AC5BAC30622D1926D3F82DEF8E729C1BF24BA135B48EB930AC8672DB0DF50C9DB1CF600ED3A8F699BD471AAB18D3C13184603AC4C9B2D6E60EBF7E41E9BA44ABFAB10F4632D2D27E0BBEC62D3B538CACE9B54C5B50F6D83ABED6B5A36763D00E88109102F599621939D89509D4449390E66EF926FEF1455DAA0DCED6998066DE309CB836D60708BAE11E99DB0CECF99672B1672354BD5486C9C85030CD7FE7A440F1BA5E5BD160FFFFBF9EEB7EFD044CBE11D86A5B0C68B08A1C1510F8A915E318F9964F650C7CD8CCC953EDABFC7ECF41AA96BAB7731B617D3414043D2E888B5C14C19E6E058110F451AEF4D310F8A36AE0AE8F5DD36AAA852844448D48B484335253BE7414D82C024F94BCEA4C0785B8125D3620DCE97B397E082B91C2CC8FFCFB2A2CEA5F2948DF51F6E0F11C87D753F1C9DD9272D0CFDC22C7F66F627C5B63F7FD725309E52270CF8C3F3BDACC829495706B19718EB9DF0C6D93F6E8F98765F1063E44B6C5A13E17551030F75D71AAD65167A6D6ABA31A82EA25A64908D257896223737D68B35E31EAF393857ECEF2F4CE62872AB56902EF443EEB3DCDF38076A257BAF05313DEEBF58707DCCF143169EDCF70801610A0C011EF46FB9906983FB6E4FF11C3011CAA42A714485EF2F686EB36B2CDD1B7DA2A18ABE3964A043833C81CA64A88F079DB017780B367C47F9081BDC6BF5943B6CE4F544F4698FE7826D2C53AEB2D1EA878F1E1ABE7ADEFF0BBA6D86D6270D0000, N'6.1.3-40302')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201710270235189_20171026', N'Democracy.Migrations.Configuration', 0x1F8B0800000000000400CD57C96E233710BD07C83F34784A008FE8E59218AD1938921D0819D9C6B467EE14BB2413E1D221D986F46D73C827E51752EC7D91648D3140025DD4642DAF5E6DDDFF7CFD3BFEB055327A01EB84D1537231392711686E52A1375392FBF5BB5FC887F73FFE10DFA66A1B7DA9E5AE821C6A6A3725CFDE67D7943AFE0C8AB98912DC1A67D67EC28DA22C35F4F2FCFC577A7141014D10B41545F1A75C7BA1A078C0C799D11C329F33B9342948579DE34D52588DEE990297310E53320765B8657C37296549742305431C09C8358998D6C6338F28AF3F3B48BC357A936478C0E4D32E03945B33E9A0427FDD8A9F1AC8F9650884B68AB5299E3B6FD4371ABCB8AA98A143F537F14B1AE690BB5BE4D8EF42D4057FC8105AC6C8879EAE67D206A931B79342E32C6ACECF9A12C04A09BFB368964B9F5B986AC8BD65F22C7ACC5752F03F60F764FE043DD5B9945D58080CEF7A0778F4684D06D6EF3EC1BA0B76919288F695E950BBD11D2A96312DB4BFBA24D13DC2602B094DFE3BF127DE58F81D3458D44C1F99F760317D8B140A064710060EE7E0B815192F92563AC5BAC30622D1926D3F82DEF8E729C1BF24BA135B48EB930AC8672DB0DF50C9DB1CF600ED3A8F699BD471AAB18D3C13184603AC4C9B2D6E60EBF7E41E9BA44ABFAB10F4632D2D27E0BBEC62D3B538CACE9B54C5B50F6D83ABED6B5A36763D00E88109102F599621939D89509D4449390E66EF926FEF1455DAA0DCED6998066DE309CB836D60708BAE11E99DB0CECF99672B1672354BD5486C9C85030CD7FE7A440F1BA5E5BD160FFFFBF9EEB7EFD044CBE11D86A5B0C68B08A1C1510F8A915E318F9964F650C7CD8CCC953EDABFC7ECF41AA96BAB7731B617D3414043D2E888B5C14C19E6E058110F451AEF4D310F8A36AE0AE8F5DD36AAA852844448D48B484335253BE7414D82C024F94BCEA4C0785B8125D3620DCE97B397E082B91C2CC8FFCFB2A2CEA5F2948DF51F6E0F11C87D753F1C9DD9272D0CFDC22C7F66F627C5B63F7FD725309E52270CF8C3F3BDACC829495706B19718EB9DF0C6D93F6E8F98765F1063E44B6C5A13E17551030F75D71AAD65167A6D6ABA31A82EA25A64908D257896223737D68B35E31EAF393857ECEF2F4CE62872AB56902EF443EEB3DCDF38076A257BAF05313DEEBF58707DCCF143169EDCF70801610A0C011EF46FB9906983FB6E4FF11C3011CAA42A714485EF2F686EB36B2CDD1B7DA2A18ABE3964A043833C81CA64A88F079DB017780B367C47F9081BDC6BF5943B6CE4F544F4698FE7826D2C53AEB2D1EA878F1E1ABE7ADEFF0BBA6D86D6270D0000, N'6.1.3-40302')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201711010436499_InitialCreate', N'Democracy.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EDC36107D2FD07F10F4D416CECA9726488DDD04CEDA6E8DC617649DA06F0157E2AE8548942A518E8DA25FD6877E527FA14389BAF1A2CBAEBCBB0E020416393C331C0EC9E170B8FFFDF3EFF8ED83EF19F7388ADD804CCC83D1BE696062078E4B961333A18B17AFCDB76FBEFF6E7CE6F80FC6A79CEE88D1414B124FCC3B4AC363CB8AED3BECA378E4BB7614C4C1828EECC0B790135887FBFBBF58070716060813B00C63FC2121D4F571FA019FD380D838A409F22E03077B312F879A598A6A5C211FC721B2F1C43CC57E6047C87E1C65B4A671E2B908E498616F611A889080220A521E7F8CF18C460159CE422840DEED6388816E81BC1873E98F4BF2AE1DD93F641DB1CA8639949DC434F07B021E1C71CD5862F395F46B169A03DD9D818EE923EB75AABF8979E1E0B4E843E081024486C7532F62C413F3B26071128757988EF286A30CF23C02B8AF41F4655445DC333AB7DB2B2CE970B4CFFEED19D3C4A349842704273442DE9E7193CC3DD7FE1D3FDE065F30991C1DCC1747AF5FBE42CED1AB9FF1D1CB6A4FA1AF40572B80A29B28087104B2E145D17FD3B0EAED2CB161D1ACD226D30AD8124C0AD3B8440FEF3159D23B982E87AF4DE3DC7DC04E5EC28DEB2371610E41231A25F07995781E9A7BB8A8B71A79B2FF1BB81EBE7C3508D72B74EF2ED3A117F8C3C489605E7DC05E5A1BDFB96136BD6AE3FD99939D4781CFBEEBF695D57E9E054964B3CE045A925B142D31AD4B37B64AE3ED64D20C6A78B3CE5177DFB499A4B2792B495987569909398B4DCF865CDEA7E5DBD9E24EC210062F352DA691268313B7AA91D076CF28284AB339E86A3604BAF32DAF82673E72BD0196C10E5CC0FF58B8918F8B5EBE0BC0E810E92DF30D8A6358059CDF507CD7203AFC3980E8336C271118E78C223F7C726E377701C157893F6736BF395E830DCDEDD7E01CD93488CE086BB536DEFBC0FE1224F48C38A788E28FD4CE01D9E7ADEB770718449C13DBC6717C0EC68C9D6900EE750E7841E8D1616F38B63C6DDB0D997AC8F5D57E88B0907ECE494B5F444D21F9231A32954FD224EAFB60E9926EA2E6A47A51338A565139595F511958374939A55ED094A055CE8C6A302F2F1DA1E1DDBC1476F7FDBCF5366FDD5A5051E30C5648FC2B26388265CCB94194E2889423D065DDD886B3900E1F63FAE47B53CAE913F292A159AD341BD24560F8D990C2EEFE6C48C584E27BD7615E4987C34F4E0CF09DE8D5E7AAF6392748B6E9E950EBE6A6996F660DD04D9793380E6C379D058AB0170F5AD4E5071FCE688F6064BD11A320D0313074976D7950027D3345A3BA26A7D8C3141B277616169CA2D8468EAC46E890D343B07C475508564643EAC2FD24F1044BC7116B84D821288699EA122A4F0B97D86E88BC562D092D3B6E61ACEF050FB1E61487983086AD9AE8C25C1DFC6002147C844169D3D0D8AA585CB3216ABC56DD98B7B9B0E5B84B31898DD8648BEFACB14BEEBF3D8961366B6C03C6D9AC922E02680379DB30507E56E96A00E2C165D70C543831690C94BB541B31D0BAC6B660A075953C3B03CD8EA85DC75F38AFEE9A79D60FCA9BDFD61BD5B505DBACE963C74C33F33DA10D85163892CDF374CE2AF103551CCE404E7E3E8BB9AB2B9A08039F615A0FD994FEAED20FB59A4144236A022C0DAD05945F014A40D284EA215C1ECB6B948E7B113D60F3B85B232C5FFB05D88A0DC8D8D5ABD00AA1FEC25434CE4EA78FA26785354846DEE9B050C1511884B878D53BDE4129BAB8ACAC982EBE701F6FB8D2313E180D0A6AF15C354ACA3B33B89672D36CD792CA21EBE392ADA525C17DD26829EFCCE05AE236DAAE248553D0C32D584B45F52D7CA0C996473A8ADDA6A81B5B597E142F185B9A44AAF1250A43972C2B8955BCC498655955D317B3FE09477E8661D9B122EFA890B6E04483082DB1500BAC41D273378AE929A2688E589C67EAF81299726FD52CFF39CBEAF6290F62BE0FE4D4ECEFAC8574715FDB69655784239C43FF7CE6CFA44174C5E8AB9B1B2CCD0D792852C4EDA78197F844EF5EE95B67B777D5F659898C30B604F925F749D295E4E4D615DF6958E42931C81015BECBEAC3A487D0293BF73CABEAD679A37A943C385545D105ACB6366C3A27A6C75089DE61FF916A45789A39C55352AA00BCA8274625AB4102ABD47547AD279E5431EB35DD1185EC922AA450D543CA6A0E494DC86AC54A781A8DAA29BA7390B346AAE8726D776445FE48155A51BD02B64266B1AE3BAA22C5A40AACA8EE8E5DE69B884BE80EEF5ADA33CB8ADB5676A85D6FDFD2603CCD7A38CCB657B9BBAF02558A7B62F1DB79098C97EFA42D694F762BDA5216C958CF963418FA55A776E75D5F741A2FEAF598B58BECDAC2DE7491AFC7EB67B14F6A17D2B14E2429B817C73BE11837E647AAF64733D2192B23318D5C8DB0A93FC614FB2346309AFDE94D3D17B3253C27B844C45DE09866C91BE6E1FEC1A1F0F266775EC15871EC788A23A9EE294C7DCC36908745EE5164DFA148CE8A58E3A548092A059C2F88831F26E65F69ABE33476C1FE4A8BF78C8BF82371FF4CA0E2364AB0F1B79CE5394CE67CF3F16A47DF3974D7EAC51F9FB3A67BC6750433E6D8D81774B9CA08D75F3FF492266BBA86342BBF8978BE13AAF6E840892A4C88D5DF18CC5D3AC8FB825CCA1F7CF4F0635FD1946F08D64254BC13180A6F1015EADE01AC82A57D03E0C0274DDF00F4EBACFA4DC02AA269DF03B8A43F98F81AA0FB3294B7DCE256A338116D62494AF5DC9A4DBD566AE5B6F72629E97AAD892E2756F7805B23797A05CB786679C783ED8E8AB4E2C1B0B769DA4F9E4BBC2BE9C36562C776B386379928DC7021F44DE507EF40469B224367FB59C09BB6355D1477C75329FBE5FAEE98B1F1BCADED67F46EDAD87461DE1D37B65E79BB3B666BDBDA3FB76C699DB7D0AD67E1CA09459ADB18552CB82DCB360B9CC3097F1E8011641E65F638529DD6D59492DAC2B024D133D5E793898CA58923F195289AD9F6EB2BDFF01B3BCB699AD96AB2309B78F3F5BF9137A769E6ADC96DDC467EB032BB5095B3DDB28E35A53F3DA77CE05A4F5AD2CFDB7CD6C6ABF5E794FE3B88526AB3477347FC7CB27D0751C99053A74776AF7CDD0B7B67E5971461FF8EDD6509C17E579160BBB66B1634176411E49BB720514E2244682E31450E6CA927117517C8A650CD62CCE9EBEE346EC76E3AE6D8B920D7090D130A5DC6FEDCAB05BC9813D0C43F4D61AECB3CBE0ED31F2A19A20B20A6CB62F3D7E45DE27A4E21F7B92226A48160DE058FE8B2B1A42CB2BB7C2C90AE02D21188ABAF708A6EB11F7A00165F9319BAC7ABC806E6F71E2F91FD5846007520ED035157FBF8D445CB08F931C728DBC327D8B0E33FBCF91F6EED28FB50540000, N'6.1.3-40302')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201711010437433_AutomaticMigration', N'Democracy.Migrations.Configuration', 0x1F8B0800000000000400E55CCD6EDC3610BE17E83B083AB585EBB59D06688DDD16CEDA0E168DE3D4EBA4BD05B444AF8548944A51868DA24FD6431FA9AFD0A1FEC51F4994B46BA7452E36C9F9389C190E49CDE7FCF3D7DFF39F1E02DFBAC734F642B2B00FF70F6C0B1327743DB259D809BBFDF67BFBA71FBFFC627EE6060FD68762DC0B3E0E2449BCB0EF188B8E67B3D8B9C3018AF703CFA1611CDEB27D270C66C80D674707073FCC0E0F6718206CC0B2ACF955429817E0F417F875191207472C41FE45E8623FCEDBA1679DA25A6F5180E3083978619FE2207428721EF7B3B1B675E27B08F45863FFD6B6102121430CB43C7E1FE335A321D9AC236840FEF5638461DC2DF2639C6B7F5C0DEFBB908323BE90592558403949CCC2C010F0F0456E9999283EC8BE766939B0DD19D8983DF255A7F65BD8AF6998441738B8C1D4B6C4F98E973EE563650BEFD7E4F6ACB277AF0C07881AFE6FCF5A263E4B285E109C308AFC3DEB5D72E37BCECFF8F13AFC84C98224BE5F57119484BE460334BDA36184297BBCC2B7B2E22BD7B6664D8899885122A8C5B355AE087B71645B6F412574E3E3322E6A1659B390E2D798608A1876DF21C63005B7AE5C9C5A565244356DF784ED2010C43D941630DEA27B6F93AE41A5926D5D613FED8DEFBC28DB38998F3FD62C051BEB9C86C155E817728DDE8FD7886E3003C542ED90759850C7403BBE56A572BC43AB9BD429A9268F5069369F551BA67B1B996FA027DC3A8337CD2EB7CB298E1DEA454E9AFBB249217DC339645B17E8E10D261B76B7B0BF8383E7DC7BC06ED190EBF19E78706A810CA3091EBB43CA289B62A314B1D6B2518A801D148ED9AE3188462EF034C1582433D358EC9704A70B453E1FFFA9250E0F0FA6094461E6738FC6AC63EA975B99F90D7AA289DFDD85A46DD6A3ADCC7AE2BA14C7F1EE3DFC9A22B76DB9F063AF697BDC3DB63E0BB88E85ADAEEB67C2C992B3E145414CCDFAABC4A0CCBC866C848D52732AF134B9399D7A48722E05FF5F17850FA1CF604E751C7E0879DFC73C00AA10ACB74BD7D446E7A81B6A8664147999C8D3845E36F790D8AB24FF93C1376CA7B5835CE100D14F6D07DF3467C329E87AED051894A6AC98AD6834D6BA103C23EE68AC557C1ED213DFE7D9BEB4C3AB10F6202203C0CE081FEEBEF211F904F188C722FE92A0341239563CCED70554A9DB48BC2522AEE782DD7FF5C8741F25F22C39348D8A87B832C7F649A327711C3A5EAA43FDBED1BC4F34D704E168753FFCB28D563E1E61B34122F522489DA0055C342553B5C296C786005B7CD86B827F238143DEC594273BE42FC1DA90C93DC2E424ED11C78B90DFB93C41D2E4230477453991D8738A234C7852EEB4C4480DCA8984B3A7CB4EF3592D60DAE348BE96EAFCDD7247ADDC9DBDF8FB0751CB17B25DC690766D7D1CA8FE746014415A338C9B7F07F1D3C8833A2FAB9362E5E0E252D8E55B0DA22264F2BCDC158883824535771F3F699E314681A2B2E4C8B9270F92EC08031906129896B7D3ECF64ED31EFCC0146F0088E4FC1910E73739D1FF1C798D99F2D15D1D9DAABC218592024A0BD2299E5FD824E92C1F7608A7CE5149E751DC219EC5844ABED8570240CD6F8201840F14B581FA4FCC6240F5BA78946BA82C2F4566AFAB860854EA2EBED79A8BEE6110C5071BD91E1DC767CF03B4B6883C905A8CA13F32B7678BE66D573683FE14E83E076A5A9791DCB27C65E6AF61149BA9F79A8B3B7799B0AA12FF2CABF1175C8099860C30BF4051C415AF24F3166B9D310396DFAECD8BE6418631736245EDBCD4B69C8985146DB0D00B5383A6E9A77B7894A21BC45F3F4B379086C9E95993748AF9141958765A918F0A21FE73F3385055F215275A0E700E4B0CF869987E2A51C7BB2C9D9235908F687BF17D19FA49407A94F53B3195686638C5A5AE0EA3BBE8F1D0140C249DF2922F84ED21FAB7BFF7A7F0FB508F1BFA7A02BF343EB2D5B11A1DCFC643D97132CA41E915C6DC3F6AB169C2BD0D252B148A38596B7FA45AB1B30E556BEE8F55952FEB50556B7FA4BC1E5987C99BFA6394D5C53A4AD96892E8D26261733BA54D86C952B1250D6DC20B7D824D78D3B3D984F99564D42E545EAD7A6C438D9CCE9AE53BB16E4FEDE3518FF399A5C9E2E239CA45F96BCBDC473A419D71ABD252DDB2BA52D536DCB4EDF0292B41759CB2D1607DCD4A4F6385CD2E73CCB4DEA3424C3BFAE309359F3AA2D0658229977E9AC0727F7F74A10C540716BACC31EBF5201570BDBF3FBA581DAA238B7D3B4E4AD2F3531C52CE5E3E4385E7E63C7FFA7513D4A5B76036C4B6C05CF79ECBDF81EBC798E1609F0FD85FFFEE2F7D0FD65B0DB840C4BBC531CBAAEAF6D1C1E191C0727F3E8CF3591CBBBEE2E9ACA19D375DF664E46F8F9BBB930960CCEC6A3066D339A4AFAF2BE2E28785FD472A736CAD7EFB988BED5997147C7F6C1D587F8E6489F79D39933298D890223DD4D913D095B7E26005F783DC23EADC212AB13FA6B1A3FCBEDB25D1762B4614B9B59505BB22B6904C9BF7AC55FC9E78BF27D0714D13CC6357246F8EE5DE2A9DFBD21C58A4D64E85DB60CE2A418FCC410562AC127688751BBCD702F5AB003D7C5D8732E6B68E426AF05735063C68073524830ED8CB531133FF232951F58EDB35CDF0799BB25F24F4B81FE462A36E2602DD70D47655520AF9A3824D44291C8CA5A414DE786C423AE11034259530F5FE6444C221686A1A6137D2F6887B1390F40A0AC4EE6979BBA5E069AB879F37E96E14C1EEE902405337DA0A7FCED4FDCF9F3297532DCC296D22536210D16E90C375258A6D32E13E13F29B4CC2D0942514DFA53A786DD9273CB820DCF0E7427640B5B27F9473E9896F5AFC6EE42C576938712A5CE5776E355D4ECF9653016B48416A265D0B914E85AD212DED96652793BFBA0975CDF8926834CF944127B1E59EC14227A2C73502BB56BDEDA6C3295874DB61C0C9A506C895B5FF3107D274EC6D2A08FEFFE710EC34B2643966456EC3225B0B1A154384EBF90566086EE7E88432EF16390CBA1D1CC7E9723F203F812167E05377452E1316250C960C3EF61B7F3AC7937EDBFC29CDAFA9F3FC324AFFFC678A25809AE903E392BC4A3CDF2DF53E573C2A3410FC34C95FF7DC978CBFF2378F25D25B8911A203CACD571E82D738887C9E292FC91ADDE321BAC18E7C8337C8792C2A467A906E4734CD3E3FF5D086A220CE312A79F81562D80D1E7EFC17561B1B9E384A0000, N'6.1.3-40302')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'ecfe44b2-7650-4d3b-abeb-6f4335e680b1', N'User')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8f00e70e-b863-468f-af07-df8e77249853', N'ecfe44b2-7650-4d3b-abeb-6f4335e680b1')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'7fef28c4-88a2-4f4d-bd79-8f1976c1cc78', N'eder-martinez@hotmail.com', 0, N'AOSWDtpwuviRsGJ2DwW1Yby54eoPwvp0VTPHfTYxqMvKn1Mh1lJwwUx9AFULnJdkkA==', N'28a174bd-8330-493e-b68f-77f2226b7e54', NULL, 0, 0, NULL, 1, 0, N'eder-martinez@hotmail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'8f00e70e-b863-468f-af07-df8e77249853', N'martinez@gmail.com', 0, N'AI0AAjOtIAv1+IClB3hlcf2Jps/obYQ0P6IOdhduHrujY+RMfn4zNSACOmmdiuOj6Q==', N'bf07430e-4165-4922-b85e-0f00b83577c7', N'45634342', 0, 0, NULL, 0, 0, N'martinez@gmail.com')
SET IDENTITY_INSERT [dbo].[GroupMembers] ON 

INSERT [dbo].[GroupMembers] ([GroupMemberId], [GroupId], [UserId]) VALUES (2, 1, 1)
INSERT [dbo].[GroupMembers] ([GroupMemberId], [GroupId], [UserId]) VALUES (4, 1, 2)
SET IDENTITY_INSERT [dbo].[GroupMembers] OFF
SET IDENTITY_INSERT [dbo].[Groups] ON 

INSERT [dbo].[Groups] ([GroupId], [Descripcion]) VALUES (1, N'Teacher Ap')
INSERT [dbo].[Groups] ([GroupId], [Descripcion]) VALUES (2, N'Alumno B')
SET IDENTITY_INSERT [dbo].[Groups] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [UserName], [FirstName], [LastName], [Phone], [Address], [Grade], [Group], [Photo]) VALUES (1, N'eder-martinez@gmail.com', N'eder', N'joao', N'23455664', N'av jose pardo', N'A', N'Grupo1', N'~/Content/Photos/Captura de pantalla (1).png')
INSERT [dbo].[Users] ([UserId], [UserName], [FirstName], [LastName], [Phone], [Address], [Grade], [Group], [Photo]) VALUES (2, N'martinez@gmail.com', N'geraldine', N'alicia', N'45634342', N'av  licas344', N'C', N'Grupo2', N'~/Content/Photos/Captura de pantalla (6).png')
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 02/11/2017 16:14:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 02/11/2017 16:14:19 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 02/11/2017 16:14:19 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 02/11/2017 16:14:19 ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 02/11/2017 16:14:19 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 02/11/2017 16:14:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GroupId]    Script Date: 02/11/2017 16:14:19 ******/
CREATE NONCLUSTERED INDEX [IX_GroupId] ON [dbo].[GroupMembers]
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserId]    Script Date: 02/11/2017 16:14:19 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[GroupMembers]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 02/11/2017 16:14:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[Users]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_StateId]    Script Date: 02/11/2017 16:14:19 ******/
CREATE NONCLUSTERED INDEX [IX_StateId] ON [dbo].[Votings]
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[GroupMembers]  WITH CHECK ADD  CONSTRAINT [FK_dbo.GroupMembers_dbo.Groups_GroupId] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([GroupId])
GO
ALTER TABLE [dbo].[GroupMembers] CHECK CONSTRAINT [FK_dbo.GroupMembers_dbo.Groups_GroupId]
GO
ALTER TABLE [dbo].[GroupMembers]  WITH CHECK ADD  CONSTRAINT [FK_dbo.GroupMembers_dbo.Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[GroupMembers] CHECK CONSTRAINT [FK_dbo.GroupMembers_dbo.Users_UserId]
GO
ALTER TABLE [dbo].[Votings]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Votings_dbo.States_StateId] FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([StateId])
GO
ALTER TABLE [dbo].[Votings] CHECK CONSTRAINT [FK_dbo.Votings_dbo.States_StateId]
GO
USE [master]
GO
ALTER DATABASE [Democracy] SET  READ_WRITE 
GO
