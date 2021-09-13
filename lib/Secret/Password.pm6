use v6.c

use NativeCall;

use Secret::Raw::Types;
use Secret::Raw::Password;

use GLib::GList;

use GLib::Roles::StaticClass;

class Secret::Password {
  also does GLib::Roles::StaticClass;

  proto method clear (|)
  { * }

  multi method clear (
    SecretSchema() $schema,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($schema, $cancellable, &callback, $user_data);
  }
  multi method clear (
    SecretSchema() $schema,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_password_clear($schema, $cancellable, &callback, $user_data);
  }

  method clear_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so secret_password_clear_finish($result, $error);
    set_error($error);
    $rv;
  }

  method clear_sync (
    SecretSchema()          $schema,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so secret_password_clear_sync($schema, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method clearv (|)
  { * }

  multi method clearv (
    GHashTable()   $attributes,
                   &callback,
    gpointer       $user_data    = gpointer,
    SecretSchema() :$schema      = SecretSchema,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($schema, $attributes, $cancellable, &callback, $user_data);
  }
  multi method clearv (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_password_clearv($schema, $attributes, $cancellable, &callback, $user_data);
  }

  proto method clearv_sync (|)
  { * }

  multi method clearv_sync (
    GHashTable()            $attributes,
    CArray[Pointer[GError]] $error        = gerror,
    SecretSchema()          :$schema      = SecretSchema,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($schema, $attributes, $cancellable, $error)
  }
  multi method clearv_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so secret_password_clearv_sync(
      $schema,
      $attributes,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  # cw: I don't see the utility of exposing this to the public interface.
  #     Nor do I see any point for coerciveness, here.
  method !free (Str $password) {
    secret_password_free($password);
  }

  proto method lookup (|)
  { * }

  multi method lookup (
    SecretSchema() $schema,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    samewith($schema, $cancellable, &callback, $user_data);
  }
  multi method lookup (
    SecretSchema() $schema,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_password_lookup($schema, $cancellable, &callback, $user_data);
  }

  method lookup_binary_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  ) {
    clear_error;
    my $sv = secret_password_lookup_binary_finish($result, $error);
    set_error($error);
    propReturnObject($sv, $raw, SecretValue, Secret::Value);
  }

  method lookup_binary_sync (
    SecretSchema()          $schema,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  ) {
    clear_error;
    my $sv = secret_password_lookup_binary_sync($schema, $cancellable, $error);
    set_error($error);
    propReturnObject($sv, $raw, SecretValue, Secret::Value);
  }

  method lookup_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  ) {
    clear_error;
    my $sv = secret_password_lookup_finish($result, $error);
    set_error($error);
    propReturnObject($sv, $raw, SecretValue, Secret::Value)
  }

  method lookup_nonpageable_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  ) {
    clear_error;
    my $sv = secret_password_lookup_nonpageable_finish($result, $error);
    set_error($error);
    propReturnObject($sv, $raw, SecretValue, Secret::Value)
  }

  method lookup_nonpageable_sync (
    SecretSchema()          $schema,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  ) {
    clear_error($error);
    my $sv = secret_password_lookup_nonpageable_sync(
      $schema,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($sv, $raw, SecretValue, Secret::Value)
  }

  method lookup_sync (
    SecretSchema()          $schema,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  ) {
    clear_error;
    my $sv = secret_password_lookup_sync($schema, $cancellable, $error);
    set_error($error);
    propReturnObject($sv, $raw, SecretValue, Secret::Value);
  }

  proto method lookupv (|)
  { * }

  multi method lookupv (
    GHashTable()   $attributes,
                   &callback,
    gpointer       $user_data    = gpointer,
    SecretSchema() :$schema      = SecretSchema,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($schema, $attributes, $cancellable, &callback, $user_data)
  }
  multi method lookupv (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_password_lookupv(
      $schema,
      $attributes,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method lookupv_binary_sync (|)
  { * }

  multi method lookupv_binary_sync (
    GHashTable()            $attributes,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror,
                            :$raw         = False
  ) {
    samewith(SecretSchema, $attributes, $cancellable, $error, :$raw);
  }
  multi method lookupv_binary_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False,
  ) {
    clear_error;
    my $sv = secret_password_lookupv_binary_sync(
      $schema,
      $attributes,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($sv, $raw, SecretValue, Secret::Value);
  }

  proto method lookupv_nonpageable_sync (|)
  { * }

  multi method lookupv_nonpageable_sync (
    GHashTable()            $attributes,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  ) {
    samewith(SecretSchema, $attributes, $cancellable, $error, :$raw);
  }
  multi method lookupv_nonpageable_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error,
                            :$raw         = False
  ) {
    clear_error;
    my $sv = secret_password_lookupv_nonpageable_sync(
      $schema,
      $attributes,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($sv, $raw, SecretValue, Secret::Value);
  }

  proto method lookupv_sync (|)
  { * }

  multi method lookupv_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  ) {
    samewith(SecretSchema, $attributes, $cancellable, $error, :$raw);
  }
  multi method lookupv_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  ) {
    clear_error;
    my $sv = secret_password_lookupv_sync(
      $schema,
      $attributes,
      $cancellable,
      $error
    );
    set_error($error);
    propReturnObject($sv, $raw, SecretValue, Secret::Value);
  }

  proto method search (|)
  { * }

  # cw: Search is SINGLE ATTRIBUTE VALUE PAIR ONLY!
  multi method search (
    SecretSchema()    $schema,
    Str()             $attribute,
                      $value,
                      &callback,
    gpointer          $user_data,
    Int()             :$flags       = 0,
    GCancellable()    :$cancellable = GCancellable
  ) {
    samewith(
      $schema,
      $flags,
      $attribute,
      $value,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method search (
    SecretSchema()    $schema,
    Int()             $flags,
    Str()             $attribute is copy,
                      $value,
    GCancellable()    $cancellable,
                      &callback,
    gpointer          $user_data

  ) {
    my SecretSearchFlags $f           = $flags;
    my Str               $value-str;
    my uint64            $value-uint;
    my int64             $value-int;

    given $value {
      when Str  { $value-str  = $value }
      when Int  { $value-uint = $value if $value >= 0;
                  $value-int  = $value if $value <  0; }
      when Bool { $attribute ~= ':BOOL';
                  $value-int  = $value.so.Int }

      default {
        die 'Value must be Str, Int or Num in call to .search()!'
      }
    }

    secret_password_search(
      $schema,
      $flags,
      $attribute,
      $cancellable,
      &callback,
      $user_data,
      $attribute,
      $value-str // $value-uint // $value-int,
      Str
    )
  }

  method search_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error,
                            :$raw         = False,
                            :$glist       = False,
                            :$object      = Secret::Retrievable
  ) {
    die ':$object must be Secret::Roles::Retrievable compatible!'
      unless $object ~~ Secret::Roles::Retrievable;

    returnGList(
      secret_password_search_finish($result, $error),
      $raw,
      $glist,
      SecretRetrievable,
      $object
    );
  }

  proto method search_sync (|)
  { * }

  multi method search_sync (
    SecretSchema()          $schema,
    Str                     $attribute    is copy,
                            $value,
    Int()                   :$flags       =  0,
    GCancellable()          :$cancellable =  GCancellable,
                            :$raw         =  False,
                            :$glist       =  False,
                            :$object      =  Secret::Retrievable,
    CArray[Pointer[GError]] :$error       =  gerror
  ) {
    samewith(
      $schema,
      $flags,
      $cancellable,
      $attribute,
      $value,
      :$raw,
      :$glist,
      :$object,
      :$error,
    );
  }
  multi method search_sync (
    SecretSchema()          $schema,
    Int()                   $flags,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error,
    Str                     $attribute    is copy,
                            $value,
                           :$raw          =  False,
                           :$glist        =  False,
                           :$object       =  Secret::Retrievable
  ) {
    my SecretSearchFlags $f           = $flags;
    my Str               $value-str;
    my uint64            $value-uint;
    my int64             $value-int;

    die '$object must be SecretRetrievable compatible'
      unless $object ~~ Secret::Roles::Retrievable;

    given $value {
      when Str  { $value-str  = $value }
      when Int  { $value-uint = $value if $value >= 0;
                  $value-int  = $value if $value <  0; }
      when Bool { $value-int  = $value.so.Int }

      default {
        die 'Value must be Str, Int or Num in call to .search()!'
      }
    }

    clear_error;
    my $srl = secret_password_search_sync(
      $schema,
      $flags,
      $cancellable,
      $error,
      $attribute,
      $value-str // $value-uint // $value-int,
      Str
    );
    set_error($error);
    returnGList($srl, $raw, $glist, SecretRetrievable, $object);
  }

  proto method searchv (|)
  { * }

  multi method searchv (
    GHashTable()    $attributes,
                    &callback,
    gpointer        $user_data    = gpointer,
    SecretSchema()  :$schema      = SecretSchema,
    Int()           :$flags       = 0,
    GCancellable()  :$cancellable = GCancellable
  ) {
    samewith(
      $schema,
      $attributes,
      $flags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method searchv (
    SecretSchema()  $schema,
    GHashTable()    $attributes,
    Int()           $flags,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    my SecretSearchFlags $f = $flags;

    secret_password_searchv(
      $schema,
      $attributes,
      $f,
      $cancellable,
      &callback,
      $user_data
    );
  }

  multi method searchv_sync (
    GHashTable()            $attributes,
    SecretSchema()          :$schema      = SecretSchema,
    Int()                   :$flags       = 0,
    GCancellable()          :$cancellable = GCancellable,
    CArray[Pointer[GError]] :$error       = gerror,
                            :$raw         = False,
                            :$glist       = False,
                            :$object      = Secret::Retrievable
  ) {
    samewith(
      $schema,
      $attributes,
      $flags,
      $cancellable,
      $error,
      :$raw,
      :$glist,
      :$object
    );
  }
  multi method searchv_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    Int()                   $flags       = 0,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False,
                            :$glist      = False,
                            :$object     = Secret::Retrievable
  ) {
    my SecretSearchFlags $f = $flags;

    clear_error;
    my $srl = secret_password_searchv_sync(
      $schema,
      $attributes,
      $f,
      $cancellable,
      $error
    );
    set_error($error);

    returnGList($srl, $raw, $glist, SecretRetrievable, $object);
  }

  proto method store (|)
  { * }

  multi method store (
    Str()          $collection,
    Str()          $label,
    Str()          $password,
    Str            $attribute,
                   $value,
                   &callback,
    SecretSchema() :$schema       =  SecretSchema,
    GCancellable() :$cancellable  =  GCancellable,
    gpointer       :$user_data    =  gpointer
  ) {
    samewith(
      $schema,
      $collection,
      $label,
      $password,
      $cancellable,
      &callback,
      $user_data,
      $attribute,
      $value
    );
  }
  multi method store (
    SecretSchema() $schema,
    Str()          $collection,
    Str()          $label,
    Str()          $password,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    is copy,
                   $attribute,
                   $value
  ) {
    $user_data //= gpointer;
    my Str               $value-str;
    my uint64            $value-uint;
    my int64             $value-int;

    given $value {
      when Str  { $value-str  = $value }
      when Int  { $value-uint = $value if $value >= 0;
                  $value-int  = $value if $value <  0; }
      when Bool { $attribute ~= ":BOOL";
                  $value-int  = $value.so.Int }

      default {
        die 'Value must be Str, Int or Num in call to .search()!'
      }
    }

    secret_password_store(
      $schema,
      $collection,
      $label,
      $password,
      $cancellable,
      &callback,
      $user_data,
      $attribute,
      $value-str // $value-uint // $value-int,
      Str
    );
  }

  proto method store_binary (|)
  { * }

  multi method store_binary (
    Str()          $collection,
    Str()          $label,
    SecretValue()  $value,
    Str()          $attribute,
                   $attr-value,
                   &callback,
    SecretSchema() :$schema      = SecretSchema,
    GCancellable() :$cancellable = GCancellable,
    gpointer       :$user_data   = gpointer,
  ) {
    samewith(
      $schema,
      $collection,
      $label,
      $value,
      $cancellable,
      &callback,
      $user_data,
      $attribute,
      $attr-value
    )
  }
  multi method store_binary (
    SecretSchema() $schema,
    Str()          $collection,
    Str()          $label,
    SecretValue()  $value,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data,
    Str()          $attribute    is copy,
                   $attr-value
  ) {
    $user_data //= gpointer;
    my Str               $attr-value-str;
    my uint64            $attr-value-uint;
    my int64             $attr-value-int;

    given $attr-value {
      when Str  { $attr-value-str  = $attr-value }
      when Int  { $attr-value-uint = $attr-value if $attr-value >= 0;
                  $attr-value-int  = $attr-value if $attr-value <  0; }
      when Bool { $attribute ~= ':BOOL';
                  $attr-value-int  = $attr-value.so.Int }

      default {
        die 'Value must be Str, Int or Num in call to .store_binary()!'
      }
    }

    $user_data //= gpointer;
    secret_password_store_binary(
      $schema,
      $collection,
      $label,
      $value,
      $cancellable,
      &callback,
      $user_data,
      $attribute,
      $attr-value-str // $attr-value-uint // $attr-value-int,
      Str
    );
  }

  proto method store_binary_sync (|)
  { * }

  multi method store_binary_sync (
    SecretSchema()          $schema,
    Str()                   $label,
    SecretValue()           $value,
    Str()                   $attribute,
                            $attr-value,
    Str()                   :$collection  = Str,
    GCancellable()          :$cancellable = GCancellable,
    CArray[Pointer[GError]] :$error       = gerror
  ) {
    samewith(
      $schema,
      $collection,
      $label,
      $value,
      $cancellable,
      $error,
      $attribute,
      $attr-value
    );
  }
  multi method store_binary_sync (
    SecretSchema()          $schema,
    Str()                   $collection,
    Str()                   $label,
    SecretValue()           $value,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error,
    Str()                   $attribute   is copy,
                            $attr-value
  ) {
    my Str               $attr-value-str;
    my uint64            $attr-value-uint;
    my int64             $attr-value-int;

    given $attr-value {
      when Str  { $attr-value-str  = $attr-value }
      when Int  { $attr-value-uint = $attr-value if $attr-value >= 0;
                  $attr-value-int  = $attr-value if $attr-value <  0; }
      when Bool { $attribute ~= ':BOOL';
                  $attr-value-int  = $attr-value.so.Int }

      default {
        die 'Value must be Str, Int or Num in call to .store_binary()!'
      }
    }

    clear_error;
    my $rv = so secret_password_store_binary_sync(
      $schema,
      $collection,
      $label,
      $value,
      $cancellable,
      $error,
      $attribute,
      $attr-value-str // $attr-value-uint // $attr-value-int,
      Str
    );
    set_error($error);
    $rv;
  }

  method store_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error
    my $rv = so secret_password_store_finish($result, $error);
    set_error($error);
    $rv;
  }

  proto method store_sync (|)
  { * }

  multi method store_sync (
    SecretSchema()          $schema,
    Str()                   $label,
    Str()                   $password,
    Str                     $attribute    is copy,
                            $attr-value,
    Str()                   :$collection  = Str,
    GCancellable()          :$cancellable = GCancellable,
    CArray[Pointer[GError]] :$error       = gerror
  ) {
    samewith($schema, $collection, $label, $password, $cancellable, $error);
  }
  multi method store_sync (
    SecretSchema            $schema,
    Str                     $collection,
    Str                     $label,
    Str                     $password,
    GCancellable            $cancellable,
    CArray[Pointer[GError]] $error,
    Str                     $attribute    is copy,
                            $attr-value
  ) {
    my Str               $attr-value-str;
    my uint64            $attr-value-uint;
    my int64             $attr-value-int;

    given $attr-value {
      when Str  { $attr-value-str  = $attr-value }
      when Int  { $attr-value-uint = $attr-value if $attr-value >= 0;
                  $attr-value-int  = $attr-value if $attr-value <  0; }
      when Bool { $attribute ~= ':BOOl';
                  $attr-value-int  = $attr-value.so.Int }

      default {
        die 'Value must be Str, Int or Num in call to .store_binary()!'
      }
    }

    clear_error;
    my $rv = so secret_password_store_sync(
      $schema,
      $collection,
      $label,
      $password,
      $cancellable,
      $error,
      $attribute,
      $attr-value-str // $attr-value-uint // $attr-value-int,
      Str
    );
    set_error($error);
  }

  proto method storev (|)
  { * }

  multi method storev (
    GHashTable()   $attributes,
    Str()          $label,
    Str()          $password,
                   &callback,
    gpointer       $user_data    = gpointer,
    SecretSchema() :$schema      = SecretSchema,
    Str()          :$collection  = Str,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $schema,
      $attributes,
      $collection,
      $label,
      $password,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method storev (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    Str()          $collection,
    Str()          $label,
    Str()          $password,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_password_storev(
      $schema,
      $attributes,
      $collection,
      $label,
      $password,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method storev_binary (|)
  { * }

  multi method storev_binary (
    GHashTable()   $attributes,
    Str()          $label,
    SecretValue()  $value,
                   &callback,
    gpointer       $user_data    = gpointer,
    SecretSchema() :$schema      = SecretSchema,
    Str()          :$collection  = Str,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $schema,
      $attributes,
      $collection,
      $label,
      $value,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method storev_binary (
    SecretSchema() $schema,
    GHashTable()   $attributes,
    Str()          $collection,
    Str()          $label,
    SecretValue()  $value,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_password_storev_binary(
      $schema,
      $attributes,
      $collection,
      $label,
      $value,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method storev_binary_sync (|)
  { * }

  multi method storev_binary_sync (
    GHashTable()              $attributes,
    Str()                     $label,
    SecretValue()             $value,
    CArray[Pointer[GError]]   $error         = gerror,
    SecretSchema()            :$schema       = SecretSchema,
    GCancellable()            :$cancellable  = GCancellable,
    Str()                     :$collection   = Str
  ) {
    samewith(
      $schema,
      $attributes,
      $collection,
      $label,
      $value,
      $cancellable,
      $error
    );
  }
  multi method storev_binary_sync (
    SecretSchema()            $schema,
    GHashTable()              $attributes,
    Str()                     $collection,
    Str()                     $label,
    SecretValue()             $value,
    GCancellable()            $cancellable  = GCancellable,
    CArray[Pointer[GError]]   $error        = gerror
  ) {
    clear_error;
    secret_password_storev_binary_sync(
      $schema,
      $attributes,
      $collection,
      $label,
      $value,
      $cancellable,
      $error
    );
    set_error($error);
  }

  proto method storev_sync (|)
  { * }

  multi method storev_sync (
    GHashTable()            $attributes,
    Str()                   $label,
    Str()                   $password,
    CArray[Pointer[GError]] $error       = gerror,
    SecretSchema()          $schema      = SecretSchema,
    Str()                   $collection  = Str,
    GCancellable()          $cancellable = GCancellable,
  ) {
    samewith(
      $schema,
      $attributes,
      $collection,
      $label,
      $password,
      $cancellable,
      $error
    );
  }
  multi method storev_sync (
    SecretSchema()          $schema,
    GHashTable()            $attributes,
    Str()                   $collection,
    Str()                   $label,
    Str()                   $password,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    secret_password_storev_sync(
      $schema,
      $attributes,
      $collection,
      $label,
      $password,
      $cancellable,
      $error
    );
    set_error($error);
  }

  method wipe (Str() $password) {
    secret_password_wipe($password);
  }

}
