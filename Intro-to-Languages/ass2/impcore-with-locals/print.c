#include "all.h"
/* print.c 1086b */
void fprint(FILE *output, const char *fmt, ...) {
    va_list_box box;

    assert(fmt);
    va_start(box.ap, fmt);
    vprint(output, fmt, &box);
    va_end(box.ap);
    fflush(output);
}
/* print.c 1087a */
void print(const char *fmt, ...) {
    va_list_box box;

    assert(fmt);
    va_start(box.ap, fmt);
    vprint(stdout, fmt, &box);
    va_end(box.ap);
    fflush(stdout);
}
/* print.c 1087b */
static Printer *printertab[256];

void vprint(FILE *output, const char *fmt, va_list_box *box) {
    const unsigned char *p;
    bool broken = false;
                       /* made true on seeing an unknown conversion specifier */
    for (p = (const unsigned char*)fmt; *p; p++) {
        if (*p != '%') {
            putc(*p, output);
            continue;
        }
        if (!broken && printertab[*++p])
            printertab[*p](output, box);
        else {
            broken = true;  /* box is not consumed */
            fprintf(output, "%%%c", *p);
        }
    }
}
/* print.c 1087c */
void installprinter(unsigned char c, Printer *take_and_print) {
    printertab[c] = take_and_print;
}
/* print.c 1088a */
void printpercent(FILE *output, va_list_box *box) {
    (void)box;
    putc('%', output);
}
/* print.c 1088b */
void printstring(FILE *output, va_list_box *box) {
    const char *s = va_arg(box->ap, char*);
    fputs(s == NULL ? "<null>" : s, output);
}

void printdecimal(FILE *output, va_list_box *box) {
    fprintf(output, "%d", va_arg(box->ap, int));
}
