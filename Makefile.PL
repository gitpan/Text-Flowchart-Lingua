use ExtUtils::MakeMaker;


WriteMakefile(
    'NAME'		=> 'Text::Flowchart::Lingua',
    'VERSION_FROM'	=> 'Lingua.pm', 
    'PREREQ_PM'		=> {
	'IO::Scalar' => '0',
	'Parse::Yapp::Driver' => '1.05',
	'Lex' => '0',
    }, 
    ($] >= 5.005 ?    
      (ABSTRACT_FROM => 'Lingua.pm', 
       AUTHOR     => 'xern <xern@cpan.org>') : ()),
);
