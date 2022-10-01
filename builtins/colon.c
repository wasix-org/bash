#include <config.h>

#if defined (HAVE_UNISTD_H)
#  include <unistd.h>
#endif

#include "../bashansi.h"
#include "../shell.h"

/* Return a successful result. */
int
colon_builtin (
     WORD_LIST *ignore
)
{
  return (0);
}

/* Return an unsuccessful result. */
int
false_builtin (
     WORD_LIST *ignore
)
{
  return (1);
}
