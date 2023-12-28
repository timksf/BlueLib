package BlueLibTests;

interface TestHandler;
    method Action go();
    method Bool done();
endinterface

typedef enum{
    RED = 1,
    GREEN = 2,
    YELLOW = 3,
    BLUE = 4,
    MAGENTA = 5,
    CYAN = 6,
    WHITE = 7
} TermColor deriving(Eq, Bits);

//the function names become ugly really fast but can easily be aliased wherever needed

function Fmt color_format(TermColor tc) = $format("\x1b[3%01dm", tc);

String mod_prefix = "[" +  genModuleName + "]";

function Fmt color_string(String s, TermColor tc);
    return color_format(tc) + $format("%s", s) + color_format(WHITE);
endfunction

function Fmt color_fmt(Fmt f, TermColor tc) = color_format(tc) + f + color_format(WHITE);

function Action print_mod_prefixed_s(String s) = $display(mod_prefix + s);

function Action print_mod_prefixed(Fmt fmt) = $display($format("%s", mod_prefix) + fmt);

function Action print_mod_pre_color_s(String s, TermColor tc) = 
    $display($format("%s", mod_prefix) + color_string(s, tc));

function Action print_mod_pre_color(Fmt fmt, TermColor tc) = 
    $display($format("%s", mod_prefix) + color_fmt(fmt, tc));

function Action print_mod_pre_color_t_s(String s, TermColor tc) = 
action
    let t <- $time();
    Fmt prefix = $format("[t=%0d]%s", t, mod_prefix);
    $display(prefix + color_string(s, tc));
endaction;

function Action print_mod_pre_color_t_f(Fmt f, TermColor tc) = 
action
    let t <- $time();
    Fmt prefix = $format("[t=%0d]%s", t, mod_prefix);
    $display(prefix + color_fmt(f, tc));
endaction;


endpackage