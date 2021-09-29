use v6.c;

use Method::Also;

use NativeCall;

use Secret::Raw::Types;
use Secret::Raw::Prompt;

use GIO::DBus::Proxy;

our subset SecretPromptAncestry is export of Mu
  where SecretPrompt | GDBusProxy;

class Secret::Prompt is GIO::DBus::Proxy {
  has SecretPrompt $!sp;

  submethod BUILD (
    :initable-object( :$secret-Prompt ),
    :$init,
    :$cancellable
  ) {
    self.setSecretPrompt(
      $secret-Prompt,
      :$init,
      :$cancellable
    ) if $secret-Prompt;
  }

  method setSecretPrompt (
    SecretPromptAncestry $_,
                            :$init,
                            :$cancellable
  ) {
    my $to-parent;

    $!sp = do {
      when SecretPrompt {
        $to-parent = cast(GDBusProxy, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(SecretPrompt, $_);
      }
    }

    self.setGDBusProxy($to-parent, :$init, :$cancellable);
  }

  method Secret::Raw::Structs::SecretPrompt
    is also<SecretPrompt>
  { $!sp }

  multi method new (SecretPromptAncestry $secret-Prompt, :$ref = True) {
    return Nil unless $secret-Prompt;

    my $o = self.bless( :$secret-Prompt );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &secret_prompt_get_type, $n, $t );
  }

  multi method perform (
    GVariantType() $return_type,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable,
    Str()          :$window_id   = Str
  ) {
    samewith($window_id, $return_type, $cancellable, &callback, $user_data);
  }
  multi method perform (
    Str()          $window_id,
    GVariantType() $return_type,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_prompt_perform(
      $!sp,
      $window_id,
      $return_type,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method perform_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  )
    is also<perform-finish>
  {
    clear_error;
    my $v = secret_prompt_perform_finish($!sp, $result, $error);
    set_error($error);

    propReturnObject($v, $raw, GVariant, GLib::Variant);
  }

  proto method perform_sync (|)
    is also<perform-sync>
  { * }

  multi method perform_sync (
    GVariantType()          $return_type,
    CArray[Pointer[GError]] $error        = gerror,
    Str()                   :$window_id   = Str,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         = False
  ) {
    samewith($window_id, $cancellable, $return_type, $error, :$raw);
  }
  multi method perform_sync (
    Str()                   $window_id,
    GCancellable()          $cancellable,
    GVariantType()          $return_type,
    CArray[Pointer[GError]] $error        = gerror,
                            :$raw         = False
  ) {
    clear_error;
    my $v = secret_prompt_perform_sync(
      $!sp,
      $window_id,
      $cancellable,
      $return_type,
      $error
    );
    set_error($error);

    propReturnObject($v, $raw, GVariant, GLib::Variant);
  }

  multi method run (
    GVariantType()          $return_type,
    CArray[Pointer[GError]] $error        = gerror,
    Str()                   :$window_id   = Str,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         = False
  ) {
    samewith($window_id, $cancellable, $return_type, $error, :$raw);
  }
  multi method run (
    Str()                   $window_id,
    GCancellable()          $cancellable,
    GVariantType()          $return_type,
    CArray[Pointer[GError]] $error        = gerror,
                            :$raw         = False
  ) {
    clear_error;
    my $v = secret_prompt_run(
      $!sp,
      $window_id,
      $cancellable,
      $return_type,
      $error
    );
    set_error($error);

    propReturnObject($v, $raw, GVariant, GLib::Variant);
  }

}
