% vim:ft=tex:ts=2:sw=2
%
% Peking University dissertation document class
%
% Copyright (c) 2008-2009 solvethis
% Copyright (c) 2010-2013 Casper Ti. Vector
%
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3 of this license or (at
% your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The current maintainer of this work is Casper Ti. Vector.
%
% This work consists of the following files:
%   fduthss.cls
%   fduthss-gbk.def
%   fduthss-utf8.def
%   fduthss-extra.sty
\usepackage{eso-pic}
\usepackage{xspace}
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{fduthss}
	[2013/12/26 v1.4-rc4 Peking University dissertation document class]

% Process the encoding options.
\newif\iffduthss@opt@gbk \fduthss@opt@gbktrue
\DeclareOption{GBK}{\fduthss@opt@gbktrue\PassOptionsToClass{GBK}{ctexbook}}
\DeclareOption{UTF8}%
	{\fduthss@opt@gbkfalse\PassOptionsToClass{UTF8}{ctexbook}}
% Whether to enable `\Uppercase' (works problematically) in heading marks.
\newif\iffduthss@opt@uppermark \fduthss@opt@uppermarkfalse
\DeclareOption{uppermark}{\fduthss@opt@uppermarktrue}
\DeclareOption{nouppermark}{\fduthss@opt@uppermarkfalse}
% Whether to enable the default extra settings.
\newif\iffduthss@opt@extra \fduthss@opt@extratrue
\DeclareOption{extra}{\fduthss@opt@extratrue}
\DeclareOption{noextra}{\fduthss@opt@extrafalse}
% eg. `\fduthss@int@extraopt{spacing}' will expand to:
%   \DeclareOption{spacing}{\PassOptionsToClass{spacing}{fduthss-extra}}
%   \DeclareOption{nospacing}{\PassOptionsToClass{nospacing}{fduthss-extra}}
\def\fduthss@int@extraopt#1{
	\DeclareOption{#1}{\PassOptionsToClass{#1}{fduthss-extra}}
	\DeclareOption{no#1}{\PassOptionsToClass{no#1}{fduthss-extra}}
}
% Pass options to `fduthss-extra'.
% See fduthss-extra.sty for an explanation of the options.
\fduthss@int@extraopt{spacing}
\fduthss@int@extraopt{tightlist}
\fduthss@int@extraopt{pdftoc}
\fduthss@int@extraopt{spechap}
\fduthss@int@extraopt{pdfprop}
\fduthss@int@extraopt{colorlinks}
% Pass all other options to `ctexbook' document class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% Process all class options now.
\ProcessOptions\relax

% fduthss is based on ctexbook; We use `xiao 4' as default font size.
% CJKfntef provides \CJKunderline used in \maketitle.
% fancyhdr provides utilities for setting headers and footers.
\LoadClass[hyperref, cs4size, fntef, fancyhdr]{ctexbook}[2011/03/11]
% Provide support for `key = val' grammar.
\RequirePackage{keyval}
% Graphics support.
\RequirePackage{graphicx}[1999/02/16]
% Provide utilities for setting page layout.
\RequirePackage{geometry}
% Whether to enable the default extra settings.
\iffduthss@opt@extra\RequirePackage{fduthss-extra}\fi

\ifxetex\iffduthss@opt@gbk
	% No support for XeLaTeX compilation in non-unicode encoding, i.e. GBK.
	\ClassError{fduthss}%
		{XeLaTeX compilation is not supported without UTF-8}%
		{%
			XeLaTeX compilation without UTF-8 is very problematic.\MessageBreak
			Therefore please use UTF-8 encoding for the LaTeX code.%
		}
\fi\fi

\AtEndOfClass{
	% Setting chinese captions and labels.
	\iffduthss@opt@gbk\input{fduthss-gbk.def}
	\else\input{fduthss-utf8.def}
	\fi
}

% Set page layout.
\geometry{
	a4paper, height = 240mm, width = 150mm, includeheadfoot, headheight = 1.2em
}
% Internal command to set headers and footers.
\def\fduthss@int@setpagestyle{
	% Set the headers and footers on the first page in every chapter.
	\fancypagestyle{plain}{
		\fancyhf{}
		%\renewcommand{\headrulewidth}{0pt}
		\if@twoside
			\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
		\else
			\fancyhead[C]{\small\normalfont\fduthss@int@setcase{\ctitleheader}}
			\fancyfoot[C]{\small\normalfont --~\thepage~--}
		\fi
	}
	% Set the headers and footers on other pages.
	\fancypagestyle{fduthss}{
		\fancyhf{}
		\if@twoside
			\fancyhead[LE]{\small\normalfont\fduthss@int@setcase{\leftmark}}
			\fancyhead[RO]{\small\normalfont\fduthss@int@setcase{\rightmark}}
			\fancyhead[LO,RE]{%
				\small\normalfont\fduthss@int@setcase{\cuniversity\cthesisname}%
			}
			\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
		\else
			%\fancyhead[L]{\small\normalfont\fduthss@int@setcase{\leftmark}}
			%\fancyhead[R]{\small\normalfont\fduthss@int@setcase{\rightmark}}
			%\fancyfoot[C]{\small\normalfont --~\thepage~--}
			\fancyhead[C]{\small\normalfont\fduthss@int@setcase{\ctitleheader}}
			\fancyfoot[C]{\small\normalfont --~\thepage~--}
		\fi
	}
	\pagestyle{fduthss}
}
% `\MakeUppercase' works problematically.
% eg. it converts `\cite{ctex}' into `\cite{CTEX}'.
% This option can disable `\MakeUppercase' in left/right heading marks.
\iffduthss@opt@uppermark
	\def\fduthss@int@setcase#1{#1}
	\fduthss@int@setpagestyle
\else
	\def\fduthss@int@setcase#1{\nouppercase{#1}}
	\fduthss@int@setpagestyle
\fi

% eg. `\fduthss@int@infoitema{ctitle}' will expand to:
%   \def\ctitle#1{\def\@ctitle{#1}}
%   \define@key{fduthss@info}{ctitle}{\ctitle{#1}}
\def\fduthss@int@infoitema#1{
	\@namedef{#1}##1{\@namedef{@#1}{##1}}
	\define@key{fduthss@info}{#1}{\@nameuse{#1}{##1}}
}
% eg. `\fduthss@int@infoitemb{cuniversity}' will expand to:
%   \define@key{fduthss@info}{cuniversity}{\def\cuniversity{#1}}
\def\fduthss@int@infoitemb#1{
	\define@key{fduthss@info}{#1}{\@namedef{#1}{##1}}
}
% Setting document information entries.
\fduthss@int@infoitema{ctitle}
\fduthss@int@infoitema{etitle}
\fduthss@int@infoitema{cauthor}
\fduthss@int@infoitema{eauthor}
\fduthss@int@infoitema{studentid}
\fduthss@int@infoitema{date}
\fduthss@int@infoitema{school}
\fduthss@int@infoitema{cmajor}
\fduthss@int@infoitema{emajor}
\fduthss@int@infoitema{direction}
\fduthss@int@infoitema{cmentor}
\fduthss@int@infoitema{ementor}
\fduthss@int@infoitema{ckeywords}
\fduthss@int@infoitema{ekeywords}
\fduthss@int@infoitemb{cuniversity}
\fduthss@int@infoitemb{euniversity}
\fduthss@int@infoitemb{cthesisname}
\fduthss@int@infoitemb{ethesisname}
\fduthss@int@infoitemb{cabstractname}
\fduthss@int@infoitemb{eabstractname}
% Set document information using the `key = value' grammar.
\newcommand{\fduthssinfo}[1]{\setkeys{fduthss@info}{#1}}

% Usage: \fduthss@int@fillinblank{(number of lines)}{(line width)}{(contents)}
\def\fduthss@int@fillinblank#1#2#3{
	\makebox[0pt][l]{\parbox[t]{#2}{\centering{#3}}}\mbox{}%
	\parbox[t]{#2}{%
		\newcount\fduthss@tmp@linecount
		\fduthss@tmp@linecount=#1
		\loop\ifnum\fduthss@tmp@linecount>0
			% Fill specified space with underline on the bottom line. `\underline'
			% draws line on the baseline (not the bottom line), and this is why
			% `\uline' is used here instead.
			\ifnum\fduthss@tmp@linecount=1
				\uline{\makebox[#2]{}}
			\else
				\uline{\makebox[#2]{}}\\
			\fi
		\advance\fduthss@tmp@linecount by -1\relax
		\repeat%
	}%
}
% Set format of the title page (cover).
\renewcommand{\maketitle}{
	\cleardoublepage
	% Add PDF bookmark for the title page.
	\pdfbookmark[1]{\titlepagename}{titlepage}
	\begin{titlepage}
		% It will be more nice to use this line skip level in the title page.
		\linespread{1.6}\selectfont
		% Make the title page centered.
		\begin{center}
			% Emblem and inscription of the university, and type of thesis.
			{
				%\zihao{1}%
				%\includegraphics[height = 2.4em]{img/fdulogo}\hspace{0.4em}%
				%\raisebox{0.4em}{\includegraphics[height = 1.6em]{img/fduword}}\\[0.8em]
				%{\bfseries{\cthesisname}}
				
				\begin{center}
				    \includegraphics[height = 6em]{img/xiaoming}\\[2.0em]
				    {\zihao{-0}\textbf\cthesisname}\\[2.6em]
				    \includegraphics[height = 12em]{img/xiaohui}\hspace{3.0em}
				\end{center}
			}
			\vfill
			% Title of the thesis.
			{
				%\zihao{-2}{\label@ctitle}%
				%\fduthss@int@fillinblank{1}{0.65\textwidth}{\textbf{\@ctitle}}
			}
			\vfill
			% Information about the author.
			{
				% Slightly adjust the line skip when using new font size.
				\zihao{-2}\linespread{1.75}\selectfont
				\def\fduthss@tmp@len{0.56\textwidth}
				\begin{tabular}{l@{\extracolsep{0.2em}}c}
					{\label@ctitle}			&
					\fduthss@int@fillinblank{1}{\fduthss@tmp@len}{\kaishu\@ctitle}		\\
					{\label@school}			&
					\fduthss@int@fillinblank{1}{\fduthss@tmp@len}{\kaishu\@school}		\\
					{\label@cmajor}			&
					\fduthss@int@fillinblank{1}{\fduthss@tmp@len}{\kaishu\@cmajor}		\\
					{\label@cauthor}		&
					\fduthss@int@fillinblank{1}{\fduthss@tmp@len}{\kaishu\@cauthor}		\\
					{\label@studentid}	&
					\fduthss@int@fillinblank{1}{\fduthss@tmp@len}{\kaishu\@studentid}	\\
					%{\label@direction}	&
					%\fduthss@int@fillinblank{1}{\fduthss@tmp@len}{\kaishu\@direction}	\\
					{\label@cmentor}		&
					\fduthss@int@fillinblank{1}{\fduthss@tmp@len}{\kaishu\@cmentor}		\\
				\end{tabular}
			}
			\vfill
			% Date.
			{\kaishu\zihao{2}\@date}
		\end{center}
	\end{titlepage}
}

% Typesetting the Chinese abstract.
\newenvironment{cabstract}{
	\cleardoublepage
	\pdfbookmark[1]{\cabstractname}{cabstract}
	\chapter*{\zihao{-2}\cabstractname}
	\markboth{\cabstractname}{}
}{% Keywords at the bottom of the page.
	\vfill\noindent\textbf{\label@ckeywords}{\@ckeywords}
}

% Typesetting the English abstract.
\newenvironment{eabstract}{
	\cleardoublepage
	\pdfbookmark[1]{\eabstractname}{eabstract}
	\chapter*{\zihao{-2}\@etitle}
	\markboth{\eabstractname}{}
	\vspace{-2em}\par
	\begin{center}
		\zihao{-3}
		{\@eauthor} \\
		{\label@ementor}{\@ementor}
	\end{center}
	\vspace{1em}\par
	\section*{\zihao{4}\eabstractname}
	\vskip 0.5em
}{% Keywords at the bottom of the page.
	\vfill\noindent\textbf{\label@ekeywords}{\@ekeywords}
}

% Add a period to the end of an abbreviation unless there's one
% already, then \xspace.
\makeatletter
\DeclareRobustCommand\onedot{\futurelet\@let@token\@onedot}
\def\@onedot{\ifx\@let@token.\else.\null\fi\xspace}

\def\eg{\emph{e.g}\onedot} \def\Eg{\emph{E.g}\onedot}
\def\ie{\emph{i.e}\onedot} \def\Ie{\emph{I.e}\onedot}
\def\cf{\emph{c.f}\onedot} \def\Cf{\emph{C.f}\onedot}
\def\etc{\emph{etc}\onedot} \def\vs{\emph{vs}\onedot}
\def\wrt{w.r.t\onedot} \def\dof{d.o.f\onedot}
\def\etal{\emph{et al}\onedot}
\makeatother

\endinput
