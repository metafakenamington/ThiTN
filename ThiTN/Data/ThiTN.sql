USE [master]
GO
/****** Object:  Database [ThiTN]    Script Date: 12/11/2020 10:02:11 AM ******/
CREATE DATABASE [ThiTN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ThiTN', FILENAME = N'C:\Users\colyd\ThiTN.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ThiTN_log', FILENAME = N'C:\Users\colyd\ThiTN_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ThiTN] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ThiTN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ThiTN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ThiTN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ThiTN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ThiTN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ThiTN] SET ARITHABORT OFF 
GO
ALTER DATABASE [ThiTN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ThiTN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ThiTN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ThiTN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ThiTN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ThiTN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ThiTN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ThiTN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ThiTN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ThiTN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ThiTN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ThiTN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ThiTN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ThiTN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ThiTN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ThiTN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ThiTN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ThiTN] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ThiTN] SET  MULTI_USER 
GO
ALTER DATABASE [ThiTN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ThiTN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ThiTN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ThiTN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ThiTN] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ThiTN] SET QUERY_STORE = OFF
GO
USE [ThiTN]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [ThiTN]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 12/11/2020 10:02:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[CauHoi] [nvarchar](max) NOT NULL,
	[Mon] [nvarchar](20) NOT NULL,
	[A] [nvarchar](max) NOT NULL,
	[B] [nvarchar](max) NOT NULL,
	[C] [nvarchar](max) NOT NULL,
	[D] [nvarchar](max) NOT NULL,
	[DapAn] [varchar](3) NOT NULL,
	[pic] [varchar](50) NULL,
	[qID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[qID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThiSinh]    Script Date: 12/11/2020 10:02:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThiSinh](
	[masv] [varchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [char](10) NULL,
	[Lop] [nvarchar](10) NULL,
	[pass] [varchar](30) NULL,
	[pic] [varchar](50) NULL,
	[Diem] [varchar](2) NULL,
	[DiemLy] [varchar](2) NULL,
	[DiemHoa] [varchar](2) NULL,
	[DiemAnh] [varchar](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[masv] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ThiSinh] ADD  DEFAULT ('MALE') FOR [GioiTinh]
GO
/****** Object:  StoredProcedure [dbo].[AddAndEditQuestion]    Script Date: 12/11/2020 10:02:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AddAndEditQuestion]
@moded nvarchar (10),
@qID	int,
@CauHoi	nvarchar(500),
@Mon	nvarchar(20),
@A	nvarchar(500),
@B	nvarchar(500),
@C	nvarchar(500),
@D	nvarchar(500),
@DapAn	varchar(3),
@pic	varchar(50)


AS
	IF @moded='Adding'
	begin 
	insert into Question
	(CauHoi,
	 Mon,
	 A,
	 B,
	 C,
	 D,
	 DapAn,
	 pic
	)
	Values
	(@CauHoi, @Mon, @A, @B, @C, @D, @DapAn, @pic)

	end

	else if @moded='Editting'
	begin
	UPDATE Question
	set
	 CauHoi= @CauHoi,
	 Mon=@Mon,
	 A=@A,
	 B=@B,
	 C=@C,
	 D=@D,
	 DapAn=@DapAn,
	 pic=@pic
	where
	qID=@qID
	end
GO
/****** Object:  StoredProcedure [dbo].[AddOrEdit]    Script Date: 12/11/2020 10:02:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddOrEdit]
	@mode nvarchar (10),
	@masv	varchar(50),
	@HoTen	nvarchar(50),
	@NgaySinh	date,
	@GioiTinh	char(9),
	@Lop	nvarchar(10),
	@pic	varchar(50),
	@pass varchar(30)


AS
	IF @mode='Add'
	begin 
	insert into ThiSinh
	(masv,
	HoTen,
	NgaySinh,
	GioiTinh,
	Lop,
	pic,
	pass
	)
	Values
	(
	@masv, @HoTen, @NgaySinh, @GioiTinh, @Lop, @pic, @pass
	
	)
	end
	else if @mode='Edit'
	begin
	UPDATE ThiSinh
	set
	masv=@masv,
	HoTen=@HoTen,
	NgaySinh=@NgaySinh,
	GioiTinh=@GioiTinh,
	Lop=@Lop,
	pic=@pic,
	pass=@pass
	where
	masv=@masv
	end
GO
/****** Object:  StoredProcedure [dbo].[Delete]    Script Date: 12/11/2020 10:02:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Delete]
	@masv	varchar(50)
AS
  delete ThiSinh
  where masv=@masv
GO
/****** Object:  StoredProcedure [dbo].[DeleteQuestion]    Script Date: 12/11/2020 10:02:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteQuestion]
	@CauHoi nvarchar (500)
AS
  delete Question
  where CauHoi=@CauHoi
GO
/****** Object:  StoredProcedure [dbo].[Exp]    Script Date: 12/11/2020 10:02:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Exp] 
AS
    select * INTO #TempTable
	from ThiSinh
	ALTER TABLE #TempTable
    DROP COLUMN pic
	SELECT * FROM #TempTable
    DROP TABLE #TempTable
GO
/****** Object:  StoredProcedure [dbo].[View]    Script Date: 12/11/2020 10:02:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[View]
   @Mon	nvarchar(20)
  
AS
	SELECT * FROM Question
	WHERE Mon Like @Mon+'%'

GO
/****** Object:  StoredProcedure [dbo].[ViewAndSearch]    Script Date: 12/11/2020 10:02:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ViewAndSearch]
	@ten	nvarchar(50)


AS
	SELECT * FROM ThiSinh
	where HoTen  LIKE @ten+'%'


GO
USE [master]
GO
ALTER DATABASE [ThiTN] SET  READ_WRITE 
GO
