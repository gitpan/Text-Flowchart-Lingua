use Test;
BEGIN { plan tests => 3 };
ok(1);

use Text::Flowchart::Lingua;
my $p = Text::Flowchart::Lingua->new();
$src = <<SRC;
    init : width => 50, directed => 0;
        begin = box :
                string  => "BEGIN",
                x_coord => 0,
                y_coord => 0,
                width   => 9,
                y_pad   => 0
    ;


        start = box :
                string => 'Do you need to make a flowchart?',
                x_coord => 15,
                y_coord => 0
    ;


        yes = box :
                string => "Then my module may help.",
                x_coord => 0,
                y_coord => 10
    ;

        use = box :
               string => "So use it.",
               x_coord => 16,
               y_coord => 8,
               width   => 14
    ;

        no = box:
               string => "Then go do something else.",
               x_coord => 30,
               y_coord => 17
    ;


        relate
                : begin, "right"
    : start, "left", 1;


        relate
                : start, "left", 3
                : yes, "top", 5
    : reason => "Y";

        relate
                : start, "right", 2
                : no, "top", 5
    : reason => "N";

        relate
                : yes, "right", 4
    : use, "bottom", 2;

        relate
                : use, "bottom", 6
    : no, "left", 2;


SRC

$p->parse($src);

ok( $/.$p->render, '
+-------+      +-------------+                    
| BEGIN +---+  |             |                    
+-------+   +--+ Do you need |                    
               | to make a   +------+             
      +--------+ flowchart?  |      |             
      |        |             |      |             
      |        +-------------+      |             
      |                             |             
      |         +------------+      |             
      |         |            |      |             
+-----+-------+ | So use it. |      |             
|             | |            |      |             
| Then my     | +--+---+-----+      |             
| module may  |    |   |            |             
| help.       |    |   |            |             
|             +----+   |            |             
+-------------+        |            |             
                       |      +-----+-------+     
                       |      |             |     
                       |      | Then go do  |     
                       +------+ something   |     
                              | else.       |     
                              |             |     
                              +-------------+     
');

ok(($p->debug), <<'CODE');
use Text::Flowchart; use IO::Scalar; 

my $_output; tie *OUT, 'IO::Scalar', \$_output;
$Text::Flowchart::Lingua::chart = Text::Flowchart->new('width',50,'directed',0);
$Text::Flowchart::Lingua::_begin = $Text::Flowchart::Lingua::chart->box('string',"BEGIN",'x_coord',0,'y_coord',0,'width',9,'y_pad',0);
$Text::Flowchart::Lingua::_start = $Text::Flowchart::Lingua::chart->box('string','Do you need to make a flowchart?','x_coord',15,'y_coord',0);
$Text::Flowchart::Lingua::_yes = $Text::Flowchart::Lingua::chart->box('string',"Then my module may help.",'x_coord',0,'y_coord',10);
$Text::Flowchart::Lingua::_use = $Text::Flowchart::Lingua::chart->box('string',"So use it.",'x_coord',16,'y_coord',8,'width',14);
$Text::Flowchart::Lingua::_no = $Text::Flowchart::Lingua::chart->box('string',"Then go do something else.",'x_coord',30,'y_coord',17);
$Text::Flowchart::Lingua::chart->relate([$Text::Flowchart::Lingua::_begin,"right"],[$Text::Flowchart::Lingua::_start,"left",1],);
$Text::Flowchart::Lingua::chart->relate([$Text::Flowchart::Lingua::_start,"left",3],[$Text::Flowchart::Lingua::_yes,"top",5],'reason',"Y");
$Text::Flowchart::Lingua::chart->relate([$Text::Flowchart::Lingua::_start,"right",2],[$Text::Flowchart::Lingua::_no,"top",5],'reason',"N");
$Text::Flowchart::Lingua::chart->relate([$Text::Flowchart::Lingua::_yes,"right",4],[$Text::Flowchart::Lingua::_use,"bottom",2],);
$Text::Flowchart::Lingua::chart->relate([$Text::Flowchart::Lingua::_use,"bottom",6],[$Text::Flowchart::Lingua::_no,"left",2],);

$Text::Flowchart::Lingua::chart->draw(*OUT); $output = $_output
CODE



