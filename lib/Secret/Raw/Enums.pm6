use v6.c;

use GLib::Raw::Definitions;

unit package Secret::Raw::Enums;

constant SecretBackendFlags is export := guint32;
our enum SecretBackendFlagsEnum is export (
  SECRET_BACKEND_NONE             =>             SECRET_SERVICE_NONE,
  SECRET_BACKEND_OPEN_SESSION     =>     SECRET_SERVICE_OPEN_SESSION,
  SECRET_BACKEND_LOAD_COLLECTIONS => SECRET_SERVICE_LOAD_COLLECTIONS,
);

constant SecretCollectionCreateFlags is export := guint32;
our enum SecretCollectionCreateFlagsEnum is export (
  SECRET_COLLECTION_CREATE_NONE => 0 +< 0,
);

constant SecretCollectionFlags is export := guint32;
our enum SecretCollectionFlagsEnum is export (
  SECRET_COLLECTION_NONE       => 0 +< 0,
  SECRET_COLLECTION_LOAD_ITEMS => 1 +< 1,
);

constant SecretError is export := guint32;
our enum SecretErrorEnum is export (
  SECRET_ERROR_PROTOCOL            => 1,
  SECRET_ERROR_IS_LOCKED           => 2,
  SECRET_ERROR_NO_SUCH_OBJECT      => 3,
  SECRET_ERROR_ALREADY_EXISTS      => 4,
  SECRET_ERROR_INVALID_FILE_FORMAT => 5,
);

constant SecretItemCreateFlags is export := guint32;
our enum SecretItemCreateFlagsEnum is export (
  SECRET_ITEM_CREATE_NONE    =>      0,
  SECRET_ITEM_CREATE_REPLACE => 1 +< 1,
);

constant SecretItemFlags is export := guint32;
our enum SecretItemFlagsEnum is export (
  'SECRET_ITEM_NONE',
  SECRET_ITEM_LOAD_SECRET => 1 +< 1,
);

constant SecretSchemaAttributeType is export := guint32;
our enum SecretSchemaAttributeTypeEnum is export (
  SECRET_SCHEMA_ATTRIBUTE_STRING  => 0,
  SECRET_SCHEMA_ATTRIBUTE_INTEGER => 1,
  SECRET_SCHEMA_ATTRIBUTE_BOOLEAN => 2,
);

constant SecretSchemaFlags is export := guint32;
our enum SecretSchemaFlagsEnum is export (
  SECRET_SCHEMA_NONE            =>      0,
  SECRET_SCHEMA_DONT_MATCH_NAME => 1 +< 1,
);

constant SecretSchemaType is export := guint32;
our enum SecretSchemaTypeEnum is export <
  SECRET_SCHEMA_TYPE_NOTE
  SECRET_SCHEMA_TYPE_COMPAT_NETWORK
>;

constant SecretSearchFlags is export := guint32;
our enum SecretSearchFlagsEnum is export (
  SECRET_SEARCH_NONE         =>      0,
  SECRET_SEARCH_ALL          => 1 +< 1,
  SECRET_SEARCH_UNLOCK       => 1 +< 2,
  SECRET_SEARCH_LOAD_SECRETS => 1 +< 3,
);

constant SecretServiceFlags is export := guint32;
our enum SecretServiceFlagsEnum is export (
  SECRET_SERVICE_NONE             =>      0,
  SECRET_SERVICE_OPEN_SESSION     => 1 +< 1,
  SECRET_SERVICE_LOAD_COLLECTIONS => 1 +< 2,
);
