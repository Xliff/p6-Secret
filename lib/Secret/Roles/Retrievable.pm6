use v6.c;

use NativeCall;

use Secret::Raw::Types;
use Secret::Raw::Retrievable;

use GLib::HashTable;
use Secret::Value;

role Secret::Roles::Retrievable {
  has SecretRetrievable $!sr;

  method get_attributes (:$raw = False) {
    propReturnObject(
      secret_retrievable_get_attributes($!sr),
      $raw,
      GHashTable,
      GLib::GHashTable
    );
  }

  method get_created (:$raw = False) {
    my $dt = secret_retrievable_get_created($!sr);
    return $dt if $raw;
    DateTime.new($dt);
  }

  method get_label {
    secret_retrievable_get_label($!sr);
  }

  method get_modified (:$raw = False) {
    my $dt = secret_retrievable_get_modified($!sr);
    return $dt if $raw;
    DateTime.new($dt);
  }

  proto method retrieve_secret (|)
  { * }

  multi method retrieve_secret (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method retrieve_secret (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    secret_retrievable_retrieve_secret($!sr, $cancellable, &callback, $user_data);
  }

  method retrieve_secret_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  ) {
    propReturnObject(
      secret_retrievable_retrieve_secret_finish($!sr, $result, $error),
      $raw,
      SecretValue,
      Secret::Value
    );
  }

  method retrieve_secret_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  ) {
    clear_error;
    my $v = secret_retrievable_retrieve_secret_sync($!sr, $cancellable, $error);
    set_error($error);

    propReturnObject($v, $raw, SecretValue, Secret::Value);
  }

}