DROP TABLE sql_features;
CREATE TABLE sql_features (feature_id character_data, feature_name character_data, sub_feature_id character_data, sub_feature_name character_data, is_supported yes_or_no, is_verified_by character_data, comments character_data);
DROP TABLE sql_implementation_info;
CREATE TABLE sql_implementation_info (implementation_info_id character_data, implementation_info_name character_data, integer_value cardinal_number, character_value character_data, comments character_data);
DROP TABLE sql_languages;
CREATE TABLE sql_languages (sql_language_source character_data, sql_language_year character_data, sql_language_conformance character_data, sql_language_integrity character_data, sql_language_implementation character_data, sql_language_binding_style character_data, sql_language_programming_language character_data);
DROP TABLE sql_packages;
CREATE TABLE sql_packages (feature_id character_data, feature_name character_data, is_supported yes_or_no, is_verified_by character_data, comments character_data);
DROP TABLE sql_parts;
CREATE TABLE sql_parts (feature_id character_data, feature_name character_data, is_supported yes_or_no, is_verified_by character_data, comments character_data);
DROP TABLE sql_sizing;
CREATE TABLE sql_sizing (sizing_id cardinal_number, sizing_name character_data, supported_value cardinal_number, comments character_data);
DROP TABLE sql_sizing_profiles;
CREATE TABLE sql_sizing_profiles (sizing_id cardinal_number, sizing_name character_data, profile_id character_data, required_value cardinal_number, comments character_data);
DROP VIEW _pg_foreign_data_wrappers;
CREATE VIEW _pg_foreign_data_wrappers (oid, fdwowner, fdwoptions, foreign_data_wrapper_catalog, foreign_data_wrapper_name, authorization_identifier, foreign_data_wrapper_language) AS  SELECT w.oid,
    w.fdwowner,
    w.fdwoptions,
    (current_database())::sql_identifier AS foreign_data_wrapper_catalog,
    (w.fdwname)::sql_identifier AS foreign_data_wrapper_name,
    (u.rolname)::sql_identifier AS authorization_identifier,
    ('c'::character varying)::character_data AS foreign_data_wrapper_language
   FROM pg_foreign_data_wrapper w,
    pg_authid u
  WHERE ((u.oid = w.fdwowner) AND (pg_has_role(w.fdwowner, 'USAGE'::text) OR has_foreign_data_wrapper_privilege(w.oid, 'USAGE'::text)));
DROP VIEW _pg_foreign_servers;
CREATE VIEW _pg_foreign_servers (oid, srvoptions, foreign_server_catalog, foreign_server_name, foreign_data_wrapper_catalog, foreign_data_wrapper_name, foreign_server_type, foreign_server_version, authorization_identifier) AS  SELECT s.oid,
    s.srvoptions,
    (current_database())::sql_identifier AS foreign_server_catalog,
    (s.srvname)::sql_identifier AS foreign_server_name,
    (current_database())::sql_identifier AS foreign_data_wrapper_catalog,
    (w.fdwname)::sql_identifier AS foreign_data_wrapper_name,
    (s.srvtype)::character_data AS foreign_server_type,
    (s.srvversion)::character_data AS foreign_server_version,
    (u.rolname)::sql_identifier AS authorization_identifier
   FROM pg_foreign_server s,
    pg_foreign_data_wrapper w,
    pg_authid u
  WHERE ((w.oid = s.srvfdw) AND (u.oid = s.srvowner) AND (pg_has_role(s.srvowner, 'USAGE'::text) OR has_server_privilege(s.oid, 'USAGE'::text)));
DROP VIEW _pg_foreign_table_columns;
CREATE VIEW _pg_foreign_table_columns (nspname, relname, attname, attfdwoptions) AS  SELECT n.nspname,
    c.relname,
    a.attname,
    a.attfdwoptions
   FROM pg_foreign_table t,
    pg_authid u,
    pg_namespace n,
    pg_class c,
    pg_attribute a
  WHERE ((u.oid = c.relowner) AND (pg_has_role(c.relowner, 'USAGE'::text) OR has_column_privilege(c.oid, a.attnum, 'SELECT, INSERT, UPDATE, REFERENCES'::text)) AND (n.oid = c.relnamespace) AND (c.oid = t.ftrelid) AND (c.relkind = 'f'::"char") AND (a.attrelid = c.oid) AND (a.attnum > 0));
DROP VIEW _pg_foreign_tables;
CREATE VIEW _pg_foreign_tables (foreign_table_catalog, foreign_table_schema, foreign_table_name, ftoptions, foreign_server_catalog, foreign_server_name, authorization_identifier) AS  SELECT (current_database())::sql_identifier AS foreign_table_catalog,
    (n.nspname)::sql_identifier AS foreign_table_schema,
    (c.relname)::sql_identifier AS foreign_table_name,
    t.ftoptions,
    (current_database())::sql_identifier AS foreign_server_catalog,
    (s.srvname)::sql_identifier AS foreign_server_name,
    (u.rolname)::sql_identifier AS authorization_identifier
   FROM pg_foreign_table t,
    pg_foreign_server s,
    pg_foreign_data_wrapper w,
    pg_authid u,
    pg_namespace n,
    pg_class c
  WHERE ((w.oid = s.srvfdw) AND (u.oid = c.relowner) AND (pg_has_role(c.relowner, 'USAGE'::text) OR has_table_privilege(c.oid, 'SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(c.oid, 'SELECT, INSERT, UPDATE, REFERENCES'::text)) AND (n.oid = c.relnamespace) AND (c.oid = t.ftrelid) AND (c.relkind = 'f'::"char") AND (s.oid = t.ftserver));
DROP VIEW _pg_user_mappings;
CREATE VIEW _pg_user_mappings (oid, umoptions, umuser, authorization_identifier, foreign_server_catalog, foreign_server_name, srvowner) AS  SELECT um.oid,
    um.umoptions,
    um.umuser,
    (COALESCE(u.rolname, 'PUBLIC'::name))::sql_identifier AS authorization_identifier,
    s.foreign_server_catalog,
    s.foreign_server_name,
    s.authorization_identifier AS srvowner
   FROM (pg_user_mapping um
     LEFT JOIN pg_authid u ON ((u.oid = um.umuser))),
    _pg_foreign_servers s
  WHERE (s.oid = um.umserver);
DROP VIEW administrable_role_authorizations;
CREATE VIEW administrable_role_authorizations (grantee, role_name, is_grantable) AS  SELECT applicable_roles.grantee,
    applicable_roles.role_name,
    applicable_roles.is_grantable
   FROM applicable_roles
  WHERE ((applicable_roles.is_grantable)::text = 'YES'::text);
DROP VIEW applicable_roles;
CREATE VIEW applicable_roles (grantee, role_name, is_grantable) AS  SELECT (a.rolname)::sql_identifier AS grantee,
    (b.rolname)::sql_identifier AS role_name,
    (
        CASE
            WHEN m.admin_option THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_grantable
   FROM ((pg_auth_members m
     JOIN pg_authid a ON ((m.member = a.oid)))
     JOIN pg_authid b ON ((m.roleid = b.oid)))
  WHERE pg_has_role(a.oid, 'USAGE'::text);
DROP VIEW attributes;
CREATE VIEW attributes (udt_catalog, udt_schema, udt_name, attribute_name, ordinal_position, attribute_default, is_nullable, data_type, character_maximum_length, character_octet_length, character_set_catalog, character_set_schema, character_set_name, collation_catalog, collation_schema, collation_name, numeric_precision, numeric_precision_radix, numeric_scale, datetime_precision, interval_type, interval_precision, attribute_udt_catalog, attribute_udt_schema, attribute_udt_name, scope_catalog, scope_schema, scope_name, maximum_cardinality, dtd_identifier, is_derived_reference_attribute) AS  SELECT (current_database())::sql_identifier AS udt_catalog,
    (nc.nspname)::sql_identifier AS udt_schema,
    (c.relname)::sql_identifier AS udt_name,
    (a.attname)::sql_identifier AS attribute_name,
    (a.attnum)::cardinal_number AS ordinal_position,
    (pg_get_expr(ad.adbin, ad.adrelid))::character_data AS attribute_default,
    (
        CASE
            WHEN (a.attnotnull OR ((t.typtype = 'd'::"char") AND t.typnotnull)) THEN 'NO'::text
            ELSE 'YES'::text
        END)::yes_or_no AS is_nullable,
    (
        CASE
            WHEN ((t.typelem <> (0)::oid) AND (t.typlen = '-1'::integer)) THEN 'ARRAY'::text
            WHEN (nt.nspname = 'pg_catalog'::name) THEN format_type(a.atttypid, NULL::integer)
            ELSE 'USER-DEFINED'::text
        END)::character_data AS data_type,
    (_pg_char_max_length(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS character_maximum_length,
    (_pg_char_octet_length(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS character_octet_length,
    (NULL::character varying)::sql_identifier AS character_set_catalog,
    (NULL::character varying)::sql_identifier AS character_set_schema,
    (NULL::character varying)::sql_identifier AS character_set_name,
    (
        CASE
            WHEN (nco.nspname IS NOT NULL) THEN current_database()
            ELSE NULL::name
        END)::sql_identifier AS collation_catalog,
    (nco.nspname)::sql_identifier AS collation_schema,
    (co.collname)::sql_identifier AS collation_name,
    (_pg_numeric_precision(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS numeric_precision,
    (_pg_numeric_precision_radix(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS numeric_precision_radix,
    (_pg_numeric_scale(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS numeric_scale,
    (_pg_datetime_precision(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS datetime_precision,
    (_pg_interval_type(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::character_data AS interval_type,
    (NULL::integer)::cardinal_number AS interval_precision,
    (current_database())::sql_identifier AS attribute_udt_catalog,
    (nt.nspname)::sql_identifier AS attribute_udt_schema,
    (t.typname)::sql_identifier AS attribute_udt_name,
    (NULL::character varying)::sql_identifier AS scope_catalog,
    (NULL::character varying)::sql_identifier AS scope_schema,
    (NULL::character varying)::sql_identifier AS scope_name,
    (NULL::integer)::cardinal_number AS maximum_cardinality,
    (a.attnum)::sql_identifier AS dtd_identifier,
    ('NO'::character varying)::yes_or_no AS is_derived_reference_attribute
   FROM ((((pg_attribute a
     LEFT JOIN pg_attrdef ad ON (((a.attrelid = ad.adrelid) AND (a.attnum = ad.adnum))))
     JOIN (pg_class c
     JOIN pg_namespace nc ON ((c.relnamespace = nc.oid))) ON ((a.attrelid = c.oid)))
     JOIN (pg_type t
     JOIN pg_namespace nt ON ((t.typnamespace = nt.oid))) ON ((a.atttypid = t.oid)))
     LEFT JOIN (pg_collation co
     JOIN pg_namespace nco ON ((co.collnamespace = nco.oid))) ON (((a.attcollation = co.oid) AND ((nco.nspname <> 'pg_catalog'::name) OR (co.collname <> 'default'::name)))))
  WHERE ((a.attnum > 0) AND (NOT a.attisdropped) AND (c.relkind = 'c'::"char") AND (pg_has_role(c.relowner, 'USAGE'::text) OR has_type_privilege(c.reltype, 'USAGE'::text)));
DROP VIEW character_sets;
CREATE VIEW character_sets (character_set_catalog, character_set_schema, character_set_name, character_repertoire, form_of_use, default_collate_catalog, default_collate_schema, default_collate_name) AS  SELECT (NULL::character varying)::sql_identifier AS character_set_catalog,
    (NULL::character varying)::sql_identifier AS character_set_schema,
    (getdatabaseencoding())::sql_identifier AS character_set_name,
    (
        CASE
            WHEN (getdatabaseencoding() = 'UTF8'::name) THEN 'UCS'::name
            ELSE getdatabaseencoding()
        END)::sql_identifier AS character_repertoire,
    (getdatabaseencoding())::sql_identifier AS form_of_use,
    (current_database())::sql_identifier AS default_collate_catalog,
    (nc.nspname)::sql_identifier AS default_collate_schema,
    (c.collname)::sql_identifier AS default_collate_name
   FROM (pg_database d
     LEFT JOIN (pg_collation c
     JOIN pg_namespace nc ON ((c.collnamespace = nc.oid))) ON (((d.datcollate = c.collcollate) AND (d.datctype = c.collctype))))
  WHERE (d.datname = current_database())
  ORDER BY (char_length((c.collname)::text)) DESC, c.collname
 LIMIT 1;
DROP VIEW check_constraint_routine_usage;
CREATE VIEW check_constraint_routine_usage (constraint_catalog, constraint_schema, constraint_name, specific_catalog, specific_schema, specific_name) AS  SELECT (current_database())::sql_identifier AS constraint_catalog,
    (nc.nspname)::sql_identifier AS constraint_schema,
    (c.conname)::sql_identifier AS constraint_name,
    (current_database())::sql_identifier AS specific_catalog,
    (np.nspname)::sql_identifier AS specific_schema,
    ((((p.proname)::text || '_'::text) || (p.oid)::text))::sql_identifier AS specific_name
   FROM pg_namespace nc,
    pg_constraint c,
    pg_depend d,
    pg_proc p,
    pg_namespace np
  WHERE ((nc.oid = c.connamespace) AND (c.contype = 'c'::"char") AND (c.oid = d.objid) AND (d.classid = ('pg_constraint'::regclass)::oid) AND (d.refobjid = p.oid) AND (d.refclassid = ('pg_proc'::regclass)::oid) AND (p.pronamespace = np.oid) AND pg_has_role(p.proowner, 'USAGE'::text));
DROP VIEW check_constraints;
CREATE VIEW check_constraints (constraint_catalog, constraint_schema, constraint_name, check_clause) AS  SELECT (current_database())::sql_identifier AS constraint_catalog,
    (rs.nspname)::sql_identifier AS constraint_schema,
    (con.conname)::sql_identifier AS constraint_name,
    ("substring"(pg_get_constraintdef(con.oid), 7))::character_data AS check_clause
   FROM (((pg_constraint con
     LEFT JOIN pg_namespace rs ON ((rs.oid = con.connamespace)))
     LEFT JOIN pg_class c ON ((c.oid = con.conrelid)))
     LEFT JOIN pg_type t ON ((t.oid = con.contypid)))
  WHERE (pg_has_role(COALESCE(c.relowner, t.typowner), 'USAGE'::text) AND (con.contype = 'c'::"char"))
UNION
 SELECT (current_database())::sql_identifier AS constraint_catalog,
    (n.nspname)::sql_identifier AS constraint_schema,
    (((((((n.oid)::text || '_'::text) || (r.oid)::text) || '_'::text) || (a.attnum)::text) || '_not_null'::text))::sql_identifier AS constraint_name,
    (((a.attname)::text || ' IS NOT NULL'::text))::character_data AS check_clause
   FROM pg_namespace n,
    pg_class r,
    pg_attribute a
  WHERE ((n.oid = r.relnamespace) AND (r.oid = a.attrelid) AND (a.attnum > 0) AND (NOT a.attisdropped) AND a.attnotnull AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND pg_has_role(r.relowner, 'USAGE'::text));
DROP VIEW collation_character_set_applicability;
CREATE VIEW collation_character_set_applicability (collation_catalog, collation_schema, collation_name, character_set_catalog, character_set_schema, character_set_name) AS  SELECT (current_database())::sql_identifier AS collation_catalog,
    (nc.nspname)::sql_identifier AS collation_schema,
    (c.collname)::sql_identifier AS collation_name,
    (NULL::character varying)::sql_identifier AS character_set_catalog,
    (NULL::character varying)::sql_identifier AS character_set_schema,
    (getdatabaseencoding())::sql_identifier AS character_set_name
   FROM pg_collation c,
    pg_namespace nc
  WHERE ((c.collnamespace = nc.oid) AND (c.collencoding = ANY (ARRAY['-1'::integer, ( SELECT pg_database.encoding
           FROM pg_database
          WHERE (pg_database.datname = current_database()))])));
DROP VIEW collations;
CREATE VIEW collations (collation_catalog, collation_schema, collation_name, pad_attribute) AS  SELECT (current_database())::sql_identifier AS collation_catalog,
    (nc.nspname)::sql_identifier AS collation_schema,
    (c.collname)::sql_identifier AS collation_name,
    ('NO PAD'::character varying)::character_data AS pad_attribute
   FROM pg_collation c,
    pg_namespace nc
  WHERE ((c.collnamespace = nc.oid) AND (c.collencoding = ANY (ARRAY['-1'::integer, ( SELECT pg_database.encoding
           FROM pg_database
          WHERE (pg_database.datname = current_database()))])));
DROP VIEW column_domain_usage;
CREATE VIEW column_domain_usage (domain_catalog, domain_schema, domain_name, table_catalog, table_schema, table_name, column_name) AS  SELECT (current_database())::sql_identifier AS domain_catalog,
    (nt.nspname)::sql_identifier AS domain_schema,
    (t.typname)::sql_identifier AS domain_name,
    (current_database())::sql_identifier AS table_catalog,
    (nc.nspname)::sql_identifier AS table_schema,
    (c.relname)::sql_identifier AS table_name,
    (a.attname)::sql_identifier AS column_name
   FROM pg_type t,
    pg_namespace nt,
    pg_class c,
    pg_namespace nc,
    pg_attribute a
  WHERE ((t.typnamespace = nt.oid) AND (c.relnamespace = nc.oid) AND (a.attrelid = c.oid) AND (a.atttypid = t.oid) AND (t.typtype = 'd'::"char") AND (c.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'f'::"char", 'p'::"char"])) AND (a.attnum > 0) AND (NOT a.attisdropped) AND pg_has_role(t.typowner, 'USAGE'::text));
DROP VIEW column_options;
CREATE VIEW column_options (table_catalog, table_schema, table_name, column_name, option_name, option_value) AS  SELECT (current_database())::sql_identifier AS table_catalog,
    (c.nspname)::sql_identifier AS table_schema,
    (c.relname)::sql_identifier AS table_name,
    (c.attname)::sql_identifier AS column_name,
    ((pg_options_to_table(c.attfdwoptions)).option_name)::sql_identifier AS option_name,
    ((pg_options_to_table(c.attfdwoptions)).option_value)::character_data AS option_value
   FROM _pg_foreign_table_columns c;
DROP VIEW column_privileges;
CREATE VIEW column_privileges (grantor, grantee, table_catalog, table_schema, table_name, column_name, privilege_type, is_grantable) AS  SELECT (u_grantor.rolname)::sql_identifier AS grantor,
    (grantee.rolname)::sql_identifier AS grantee,
    (current_database())::sql_identifier AS table_catalog,
    (nc.nspname)::sql_identifier AS table_schema,
    (x.relname)::sql_identifier AS table_name,
    (x.attname)::sql_identifier AS column_name,
    (x.prtype)::character_data AS privilege_type,
    (
        CASE
            WHEN (pg_has_role(x.grantee, x.relowner, 'USAGE'::text) OR x.grantable) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_grantable
   FROM ( SELECT pr_c.grantor,
            pr_c.grantee,
            a.attname,
            pr_c.relname,
            pr_c.relnamespace,
            pr_c.prtype,
            pr_c.grantable,
            pr_c.relowner
           FROM ( SELECT pg_class.oid,
                    pg_class.relname,
                    pg_class.relnamespace,
                    pg_class.relowner,
                    (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).grantor AS grantor,
                    (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).grantee AS grantee,
                    (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).privilege_type AS privilege_type,
                    (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).is_grantable AS is_grantable
                   FROM pg_class
                  WHERE (pg_class.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'f'::"char", 'p'::"char"]))) pr_c(oid, relname, relnamespace, relowner, grantor, grantee, prtype, grantable),
            pg_attribute a
          WHERE ((a.attrelid = pr_c.oid) AND (a.attnum > 0) AND (NOT a.attisdropped))
        UNION
         SELECT pr_a.grantor,
            pr_a.grantee,
            pr_a.attname,
            c.relname,
            c.relnamespace,
            pr_a.prtype,
            pr_a.grantable,
            c.relowner
           FROM ( SELECT a.attrelid,
                    a.attname,
                    (aclexplode(COALESCE(a.attacl, acldefault('c'::"char", cc.relowner)))).grantor AS grantor,
                    (aclexplode(COALESCE(a.attacl, acldefault('c'::"char", cc.relowner)))).grantee AS grantee,
                    (aclexplode(COALESCE(a.attacl, acldefault('c'::"char", cc.relowner)))).privilege_type AS privilege_type,
                    (aclexplode(COALESCE(a.attacl, acldefault('c'::"char", cc.relowner)))).is_grantable AS is_grantable
                   FROM (pg_attribute a
                     JOIN pg_class cc ON ((a.attrelid = cc.oid)))
                  WHERE ((a.attnum > 0) AND (NOT a.attisdropped))) pr_a(attrelid, attname, grantor, grantee, prtype, grantable),
            pg_class c
          WHERE ((pr_a.attrelid = c.oid) AND (c.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'f'::"char", 'p'::"char"])))) x,
    pg_namespace nc,
    pg_authid u_grantor,
    ( SELECT pg_authid.oid,
            pg_authid.rolname
           FROM pg_authid
        UNION ALL
         SELECT (0)::oid AS oid,
            'PUBLIC'::name) grantee(oid, rolname)
  WHERE ((x.relnamespace = nc.oid) AND (x.grantee = grantee.oid) AND (x.grantor = u_grantor.oid) AND (x.prtype = ANY (ARRAY['INSERT'::text, 'SELECT'::text, 'UPDATE'::text, 'REFERENCES'::text])) AND (pg_has_role(u_grantor.oid, 'USAGE'::text) OR pg_has_role(grantee.oid, 'USAGE'::text) OR (grantee.rolname = 'PUBLIC'::name)));
DROP VIEW column_udt_usage;
CREATE VIEW column_udt_usage (udt_catalog, udt_schema, udt_name, table_catalog, table_schema, table_name, column_name) AS  SELECT (current_database())::sql_identifier AS udt_catalog,
    (COALESCE(nbt.nspname, nt.nspname))::sql_identifier AS udt_schema,
    (COALESCE(bt.typname, t.typname))::sql_identifier AS udt_name,
    (current_database())::sql_identifier AS table_catalog,
    (nc.nspname)::sql_identifier AS table_schema,
    (c.relname)::sql_identifier AS table_name,
    (a.attname)::sql_identifier AS column_name
   FROM pg_attribute a,
    pg_class c,
    pg_namespace nc,
    ((pg_type t
     JOIN pg_namespace nt ON ((t.typnamespace = nt.oid)))
     LEFT JOIN (pg_type bt
     JOIN pg_namespace nbt ON ((bt.typnamespace = nbt.oid))) ON (((t.typtype = 'd'::"char") AND (t.typbasetype = bt.oid))))
  WHERE ((a.attrelid = c.oid) AND (a.atttypid = t.oid) AND (nc.oid = c.relnamespace) AND (a.attnum > 0) AND (NOT a.attisdropped) AND (c.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'f'::"char", 'p'::"char"])) AND pg_has_role(COALESCE(bt.typowner, t.typowner), 'USAGE'::text));
DROP VIEW columns;
CREATE VIEW columns (table_catalog, table_schema, table_name, column_name, ordinal_position, column_default, is_nullable, data_type, character_maximum_length, character_octet_length, numeric_precision, numeric_precision_radix, numeric_scale, datetime_precision, interval_type, interval_precision, character_set_catalog, character_set_schema, character_set_name, collation_catalog, collation_schema, collation_name, domain_catalog, domain_schema, domain_name, udt_catalog, udt_schema, udt_name, scope_catalog, scope_schema, scope_name, maximum_cardinality, dtd_identifier, is_self_referencing, is_identity, identity_generation, identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle, is_generated, generation_expression, is_updatable) AS  SELECT (current_database())::sql_identifier AS table_catalog,
    (nc.nspname)::sql_identifier AS table_schema,
    (c.relname)::sql_identifier AS table_name,
    (a.attname)::sql_identifier AS column_name,
    (a.attnum)::cardinal_number AS ordinal_position,
    (pg_get_expr(ad.adbin, ad.adrelid))::character_data AS column_default,
    (
        CASE
            WHEN (a.attnotnull OR ((t.typtype = 'd'::"char") AND t.typnotnull)) THEN 'NO'::text
            ELSE 'YES'::text
        END)::yes_or_no AS is_nullable,
    (
        CASE
            WHEN (t.typtype = 'd'::"char") THEN
            CASE
                WHEN ((bt.typelem <> (0)::oid) AND (bt.typlen = '-1'::integer)) THEN 'ARRAY'::text
                WHEN (nbt.nspname = 'pg_catalog'::name) THEN format_type(t.typbasetype, NULL::integer)
                ELSE 'USER-DEFINED'::text
            END
            ELSE
            CASE
                WHEN ((t.typelem <> (0)::oid) AND (t.typlen = '-1'::integer)) THEN 'ARRAY'::text
                WHEN (nt.nspname = 'pg_catalog'::name) THEN format_type(a.atttypid, NULL::integer)
                ELSE 'USER-DEFINED'::text
            END
        END)::character_data AS data_type,
    (_pg_char_max_length(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS character_maximum_length,
    (_pg_char_octet_length(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS character_octet_length,
    (_pg_numeric_precision(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS numeric_precision,
    (_pg_numeric_precision_radix(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS numeric_precision_radix,
    (_pg_numeric_scale(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS numeric_scale,
    (_pg_datetime_precision(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::cardinal_number AS datetime_precision,
    (_pg_interval_type(_pg_truetypid(a.*, t.*), _pg_truetypmod(a.*, t.*)))::character_data AS interval_type,
    (NULL::integer)::cardinal_number AS interval_precision,
    (NULL::character varying)::sql_identifier AS character_set_catalog,
    (NULL::character varying)::sql_identifier AS character_set_schema,
    (NULL::character varying)::sql_identifier AS character_set_name,
    (
        CASE
            WHEN (nco.nspname IS NOT NULL) THEN current_database()
            ELSE NULL::name
        END)::sql_identifier AS collation_catalog,
    (nco.nspname)::sql_identifier AS collation_schema,
    (co.collname)::sql_identifier AS collation_name,
    (
        CASE
            WHEN (t.typtype = 'd'::"char") THEN current_database()
            ELSE NULL::name
        END)::sql_identifier AS domain_catalog,
    (
        CASE
            WHEN (t.typtype = 'd'::"char") THEN nt.nspname
            ELSE NULL::name
        END)::sql_identifier AS domain_schema,
    (
        CASE
            WHEN (t.typtype = 'd'::"char") THEN t.typname
            ELSE NULL::name
        END)::sql_identifier AS domain_name,
    (current_database())::sql_identifier AS udt_catalog,
    (COALESCE(nbt.nspname, nt.nspname))::sql_identifier AS udt_schema,
    (COALESCE(bt.typname, t.typname))::sql_identifier AS udt_name,
    (NULL::character varying)::sql_identifier AS scope_catalog,
    (NULL::character varying)::sql_identifier AS scope_schema,
    (NULL::character varying)::sql_identifier AS scope_name,
    (NULL::integer)::cardinal_number AS maximum_cardinality,
    (a.attnum)::sql_identifier AS dtd_identifier,
    ('NO'::character varying)::yes_or_no AS is_self_referencing,
    (
        CASE
            WHEN (a.attidentity = ANY (ARRAY['a'::"char", 'd'::"char"])) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_identity,
    (
        CASE a.attidentity
            WHEN 'a'::"char" THEN 'ALWAYS'::text
            WHEN 'd'::"char" THEN 'BY DEFAULT'::text
            ELSE NULL::text
        END)::character_data AS identity_generation,
    (seq.seqstart)::character_data AS identity_start,
    (seq.seqincrement)::character_data AS identity_increment,
    (seq.seqmax)::character_data AS identity_maximum,
    (seq.seqmin)::character_data AS identity_minimum,
    (
        CASE
            WHEN seq.seqcycle THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS identity_cycle,
    ('NEVER'::character varying)::character_data AS is_generated,
    (NULL::character varying)::character_data AS generation_expression,
    (
        CASE
            WHEN ((c.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) OR ((c.relkind = ANY (ARRAY['v'::"char", 'f'::"char"])) AND pg_column_is_updatable((c.oid)::regclass, a.attnum, false))) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_updatable
   FROM ((((((pg_attribute a
     LEFT JOIN pg_attrdef ad ON (((a.attrelid = ad.adrelid) AND (a.attnum = ad.adnum))))
     JOIN (pg_class c
     JOIN pg_namespace nc ON ((c.relnamespace = nc.oid))) ON ((a.attrelid = c.oid)))
     JOIN (pg_type t
     JOIN pg_namespace nt ON ((t.typnamespace = nt.oid))) ON ((a.atttypid = t.oid)))
     LEFT JOIN (pg_type bt
     JOIN pg_namespace nbt ON ((bt.typnamespace = nbt.oid))) ON (((t.typtype = 'd'::"char") AND (t.typbasetype = bt.oid))))
     LEFT JOIN (pg_collation co
     JOIN pg_namespace nco ON ((co.collnamespace = nco.oid))) ON (((a.attcollation = co.oid) AND ((nco.nspname <> 'pg_catalog'::name) OR (co.collname <> 'default'::name)))))
     LEFT JOIN (pg_depend dep
     JOIN pg_sequence seq ON (((dep.classid = ('pg_class'::regclass)::oid) AND (dep.objid = seq.seqrelid) AND (dep.deptype = 'i'::"char")))) ON (((dep.refclassid = ('pg_class'::regclass)::oid) AND (dep.refobjid = c.oid) AND (dep.refobjsubid = a.attnum))))
  WHERE ((NOT pg_is_other_temp_schema(nc.oid)) AND (a.attnum > 0) AND (NOT a.attisdropped) AND (c.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'f'::"char", 'p'::"char"])) AND (pg_has_role(c.relowner, 'USAGE'::text) OR has_column_privilege(c.oid, a.attnum, 'SELECT, INSERT, UPDATE, REFERENCES'::text)));
DROP VIEW constraint_column_usage;
CREATE VIEW constraint_column_usage (table_catalog, table_schema, table_name, column_name, constraint_catalog, constraint_schema, constraint_name) AS  SELECT (current_database())::sql_identifier AS table_catalog,
    (x.tblschema)::sql_identifier AS table_schema,
    (x.tblname)::sql_identifier AS table_name,
    (x.colname)::sql_identifier AS column_name,
    (current_database())::sql_identifier AS constraint_catalog,
    (x.cstrschema)::sql_identifier AS constraint_schema,
    (x.cstrname)::sql_identifier AS constraint_name
   FROM ( SELECT DISTINCT nr.nspname,
            r.relname,
            r.relowner,
            a.attname,
            nc.nspname,
            c.conname
           FROM pg_namespace nr,
            pg_class r,
            pg_attribute a,
            pg_depend d,
            pg_namespace nc,
            pg_constraint c
          WHERE ((nr.oid = r.relnamespace) AND (r.oid = a.attrelid) AND (d.refclassid = ('pg_class'::regclass)::oid) AND (d.refobjid = r.oid) AND (d.refobjsubid = a.attnum) AND (d.classid = ('pg_constraint'::regclass)::oid) AND (d.objid = c.oid) AND (c.connamespace = nc.oid) AND (c.contype = 'c'::"char") AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND (NOT a.attisdropped))
        UNION ALL
         SELECT nr.nspname,
            r.relname,
            r.relowner,
            a.attname,
            nc.nspname,
            c.conname
           FROM pg_namespace nr,
            pg_class r,
            pg_attribute a,
            pg_namespace nc,
            pg_constraint c
          WHERE ((nr.oid = r.relnamespace) AND (r.oid = a.attrelid) AND (nc.oid = c.connamespace) AND (r.oid =
                CASE c.contype
                    WHEN 'f'::"char" THEN c.confrelid
                    ELSE c.conrelid
                END) AND (a.attnum = ANY (
                CASE c.contype
                    WHEN 'f'::"char" THEN c.confkey
                    ELSE c.conkey
                END)) AND (NOT a.attisdropped) AND (c.contype = ANY (ARRAY['p'::"char", 'u'::"char", 'f'::"char"])) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])))) x(tblschema, tblname, tblowner, colname, cstrschema, cstrname)
  WHERE pg_has_role(x.tblowner, 'USAGE'::text);
DROP VIEW constraint_table_usage;
CREATE VIEW constraint_table_usage (table_catalog, table_schema, table_name, constraint_catalog, constraint_schema, constraint_name) AS  SELECT (current_database())::sql_identifier AS table_catalog,
    (nr.nspname)::sql_identifier AS table_schema,
    (r.relname)::sql_identifier AS table_name,
    (current_database())::sql_identifier AS constraint_catalog,
    (nc.nspname)::sql_identifier AS constraint_schema,
    (c.conname)::sql_identifier AS constraint_name
   FROM pg_constraint c,
    pg_namespace nc,
    pg_class r,
    pg_namespace nr
  WHERE ((c.connamespace = nc.oid) AND (r.relnamespace = nr.oid) AND (((c.contype = 'f'::"char") AND (c.confrelid = r.oid)) OR ((c.contype = ANY (ARRAY['p'::"char", 'u'::"char"])) AND (c.conrelid = r.oid))) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND pg_has_role(r.relowner, 'USAGE'::text));
DROP VIEW data_type_privileges;
CREATE VIEW data_type_privileges (object_catalog, object_schema, object_name, object_type, dtd_identifier) AS  SELECT (current_database())::sql_identifier AS object_catalog,
    x.objschema AS object_schema,
    x.objname AS object_name,
    (x.objtype)::character_data AS object_type,
    x.objdtdid AS dtd_identifier
   FROM ( SELECT attributes.udt_schema,
            attributes.udt_name,
            'USER-DEFINED TYPE'::text AS text,
            attributes.dtd_identifier
           FROM attributes
        UNION ALL
         SELECT columns.table_schema,
            columns.table_name,
            'TABLE'::text AS text,
            columns.dtd_identifier
           FROM columns
        UNION ALL
         SELECT domains.domain_schema,
            domains.domain_name,
            'DOMAIN'::text AS text,
            domains.dtd_identifier
           FROM domains
        UNION ALL
         SELECT parameters.specific_schema,
            parameters.specific_name,
            'ROUTINE'::text AS text,
            parameters.dtd_identifier
           FROM parameters
        UNION ALL
         SELECT routines.specific_schema,
            routines.specific_name,
            'ROUTINE'::text AS text,
            routines.dtd_identifier
           FROM routines) x(objschema, objname, objtype, objdtdid);
DROP VIEW domain_constraints;
CREATE VIEW domain_constraints (constraint_catalog, constraint_schema, constraint_name, domain_catalog, domain_schema, domain_name, is_deferrable, initially_deferred) AS  SELECT (current_database())::sql_identifier AS constraint_catalog,
    (rs.nspname)::sql_identifier AS constraint_schema,
    (con.conname)::sql_identifier AS constraint_name,
    (current_database())::sql_identifier AS domain_catalog,
    (n.nspname)::sql_identifier AS domain_schema,
    (t.typname)::sql_identifier AS domain_name,
    (
        CASE
            WHEN con.condeferrable THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_deferrable,
    (
        CASE
            WHEN con.condeferred THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS initially_deferred
   FROM pg_namespace rs,
    pg_namespace n,
    pg_constraint con,
    pg_type t
  WHERE ((rs.oid = con.connamespace) AND (n.oid = t.typnamespace) AND (t.oid = con.contypid) AND (pg_has_role(t.typowner, 'USAGE'::text) OR has_type_privilege(t.oid, 'USAGE'::text)));
DROP VIEW domain_udt_usage;
CREATE VIEW domain_udt_usage (udt_catalog, udt_schema, udt_name, domain_catalog, domain_schema, domain_name) AS  SELECT (current_database())::sql_identifier AS udt_catalog,
    (nbt.nspname)::sql_identifier AS udt_schema,
    (bt.typname)::sql_identifier AS udt_name,
    (current_database())::sql_identifier AS domain_catalog,
    (nt.nspname)::sql_identifier AS domain_schema,
    (t.typname)::sql_identifier AS domain_name
   FROM pg_type t,
    pg_namespace nt,
    pg_type bt,
    pg_namespace nbt
  WHERE ((t.typnamespace = nt.oid) AND (t.typbasetype = bt.oid) AND (bt.typnamespace = nbt.oid) AND (t.typtype = 'd'::"char") AND pg_has_role(bt.typowner, 'USAGE'::text));
DROP VIEW domains;
CREATE VIEW domains (domain_catalog, domain_schema, domain_name, data_type, character_maximum_length, character_octet_length, character_set_catalog, character_set_schema, character_set_name, collation_catalog, collation_schema, collation_name, numeric_precision, numeric_precision_radix, numeric_scale, datetime_precision, interval_type, interval_precision, domain_default, udt_catalog, udt_schema, udt_name, scope_catalog, scope_schema, scope_name, maximum_cardinality, dtd_identifier) AS  SELECT (current_database())::sql_identifier AS domain_catalog,
    (nt.nspname)::sql_identifier AS domain_schema,
    (t.typname)::sql_identifier AS domain_name,
    (
        CASE
            WHEN ((t.typelem <> (0)::oid) AND (t.typlen = '-1'::integer)) THEN 'ARRAY'::text
            WHEN (nbt.nspname = 'pg_catalog'::name) THEN format_type(t.typbasetype, NULL::integer)
            ELSE 'USER-DEFINED'::text
        END)::character_data AS data_type,
    (_pg_char_max_length(t.typbasetype, t.typtypmod))::cardinal_number AS character_maximum_length,
    (_pg_char_octet_length(t.typbasetype, t.typtypmod))::cardinal_number AS character_octet_length,
    (NULL::character varying)::sql_identifier AS character_set_catalog,
    (NULL::character varying)::sql_identifier AS character_set_schema,
    (NULL::character varying)::sql_identifier AS character_set_name,
    (
        CASE
            WHEN (nco.nspname IS NOT NULL) THEN current_database()
            ELSE NULL::name
        END)::sql_identifier AS collation_catalog,
    (nco.nspname)::sql_identifier AS collation_schema,
    (co.collname)::sql_identifier AS collation_name,
    (_pg_numeric_precision(t.typbasetype, t.typtypmod))::cardinal_number AS numeric_precision,
    (_pg_numeric_precision_radix(t.typbasetype, t.typtypmod))::cardinal_number AS numeric_precision_radix,
    (_pg_numeric_scale(t.typbasetype, t.typtypmod))::cardinal_number AS numeric_scale,
    (_pg_datetime_precision(t.typbasetype, t.typtypmod))::cardinal_number AS datetime_precision,
    (_pg_interval_type(t.typbasetype, t.typtypmod))::character_data AS interval_type,
    (NULL::integer)::cardinal_number AS interval_precision,
    (t.typdefault)::character_data AS domain_default,
    (current_database())::sql_identifier AS udt_catalog,
    (nbt.nspname)::sql_identifier AS udt_schema,
    (bt.typname)::sql_identifier AS udt_name,
    (NULL::character varying)::sql_identifier AS scope_catalog,
    (NULL::character varying)::sql_identifier AS scope_schema,
    (NULL::character varying)::sql_identifier AS scope_name,
    (NULL::integer)::cardinal_number AS maximum_cardinality,
    (1)::sql_identifier AS dtd_identifier
   FROM (((pg_type t
     JOIN pg_namespace nt ON ((t.typnamespace = nt.oid)))
     JOIN (pg_type bt
     JOIN pg_namespace nbt ON ((bt.typnamespace = nbt.oid))) ON (((t.typbasetype = bt.oid) AND (t.typtype = 'd'::"char"))))
     LEFT JOIN (pg_collation co
     JOIN pg_namespace nco ON ((co.collnamespace = nco.oid))) ON (((t.typcollation = co.oid) AND ((nco.nspname <> 'pg_catalog'::name) OR (co.collname <> 'default'::name)))))
  WHERE (pg_has_role(t.typowner, 'USAGE'::text) OR has_type_privilege(t.oid, 'USAGE'::text));
DROP VIEW element_types;
CREATE VIEW element_types (object_catalog, object_schema, object_name, object_type, collection_type_identifier, data_type, character_maximum_length, character_octet_length, character_set_catalog, character_set_schema, character_set_name, collation_catalog, collation_schema, collation_name, numeric_precision, numeric_precision_radix, numeric_scale, datetime_precision, interval_type, interval_precision, domain_default, udt_catalog, udt_schema, udt_name, scope_catalog, scope_schema, scope_name, maximum_cardinality, dtd_identifier) AS  SELECT (current_database())::sql_identifier AS object_catalog,
    (n.nspname)::sql_identifier AS object_schema,
    x.objname AS object_name,
    (x.objtype)::character_data AS object_type,
    (x.objdtdid)::sql_identifier AS collection_type_identifier,
    (
        CASE
            WHEN (nbt.nspname = 'pg_catalog'::name) THEN format_type(bt.oid, NULL::integer)
            ELSE 'USER-DEFINED'::text
        END)::character_data AS data_type,
    (NULL::integer)::cardinal_number AS character_maximum_length,
    (NULL::integer)::cardinal_number AS character_octet_length,
    (NULL::character varying)::sql_identifier AS character_set_catalog,
    (NULL::character varying)::sql_identifier AS character_set_schema,
    (NULL::character varying)::sql_identifier AS character_set_name,
    (
        CASE
            WHEN (nco.nspname IS NOT NULL) THEN current_database()
            ELSE NULL::name
        END)::sql_identifier AS collation_catalog,
    (nco.nspname)::sql_identifier AS collation_schema,
    (co.collname)::sql_identifier AS collation_name,
    (NULL::integer)::cardinal_number AS numeric_precision,
    (NULL::integer)::cardinal_number AS numeric_precision_radix,
    (NULL::integer)::cardinal_number AS numeric_scale,
    (NULL::integer)::cardinal_number AS datetime_precision,
    (NULL::character varying)::character_data AS interval_type,
    (NULL::integer)::cardinal_number AS interval_precision,
    (NULL::character varying)::character_data AS domain_default,
    (current_database())::sql_identifier AS udt_catalog,
    (nbt.nspname)::sql_identifier AS udt_schema,
    (bt.typname)::sql_identifier AS udt_name,
    (NULL::character varying)::sql_identifier AS scope_catalog,
    (NULL::character varying)::sql_identifier AS scope_schema,
    (NULL::character varying)::sql_identifier AS scope_name,
    (NULL::integer)::cardinal_number AS maximum_cardinality,
    (('a'::text || (x.objdtdid)::text))::sql_identifier AS dtd_identifier
   FROM pg_namespace n,
    pg_type at,
    pg_namespace nbt,
    pg_type bt,
    (( SELECT c.relnamespace,
            (c.relname)::sql_identifier AS relname,
                CASE
                    WHEN (c.relkind = 'c'::"char") THEN 'USER-DEFINED TYPE'::text
                    ELSE 'TABLE'::text
                END AS "case",
            a.attnum,
            a.atttypid,
            a.attcollation
           FROM pg_class c,
            pg_attribute a
          WHERE ((c.oid = a.attrelid) AND (c.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'f'::"char", 'c'::"char", 'p'::"char"])) AND (a.attnum > 0) AND (NOT a.attisdropped))
        UNION ALL
         SELECT t.typnamespace,
            (t.typname)::sql_identifier AS typname,
            'DOMAIN'::text AS text,
            1,
            t.typbasetype,
            t.typcollation
           FROM pg_type t
          WHERE (t.typtype = 'd'::"char")
        UNION ALL
         SELECT ss.pronamespace,
            ((((ss.proname)::text || '_'::text) || (ss.oid)::text))::sql_identifier AS sql_identifier,
            'ROUTINE'::text AS text,
            (ss.x).n AS n,
            (ss.x).x AS x,
            0
           FROM ( SELECT p.pronamespace,
                    p.proname,
                    p.oid,
                    _pg_expandarray(COALESCE(p.proallargtypes, (p.proargtypes)::oid[])) AS x
                   FROM pg_proc p) ss
        UNION ALL
         SELECT p.pronamespace,
            ((((p.proname)::text || '_'::text) || (p.oid)::text))::sql_identifier AS sql_identifier,
            'ROUTINE'::text AS text,
            0,
            p.prorettype,
            0
           FROM pg_proc p) x(objschema, objname, objtype, objdtdid, objtypeid, objcollation)
     LEFT JOIN (pg_collation co
     JOIN pg_namespace nco ON ((co.collnamespace = nco.oid))) ON (((x.objcollation = co.oid) AND ((nco.nspname <> 'pg_catalog'::name) OR (co.collname <> 'default'::name)))))
  WHERE ((n.oid = x.objschema) AND (at.oid = x.objtypeid) AND ((at.typelem <> (0)::oid) AND (at.typlen = '-1'::integer)) AND (at.typelem = bt.oid) AND (nbt.oid = bt.typnamespace) AND ((n.nspname, (x.objname)::text, x.objtype, ((x.objdtdid)::sql_identifier)::text) IN ( SELECT data_type_privileges.object_schema,
            data_type_privileges.object_name,
            data_type_privileges.object_type,
            data_type_privileges.dtd_identifier
           FROM data_type_privileges)));
DROP VIEW enabled_roles;
CREATE VIEW enabled_roles (role_name) AS  SELECT (a.rolname)::sql_identifier AS role_name
   FROM pg_authid a
  WHERE pg_has_role(a.oid, 'USAGE'::text);
DROP VIEW foreign_data_wrapper_options;
CREATE VIEW foreign_data_wrapper_options (foreign_data_wrapper_catalog, foreign_data_wrapper_name, option_name, option_value) AS  SELECT w.foreign_data_wrapper_catalog,
    w.foreign_data_wrapper_name,
    ((pg_options_to_table(w.fdwoptions)).option_name)::sql_identifier AS option_name,
    ((pg_options_to_table(w.fdwoptions)).option_value)::character_data AS option_value
   FROM _pg_foreign_data_wrappers w;
DROP VIEW foreign_data_wrappers;
CREATE VIEW foreign_data_wrappers (foreign_data_wrapper_catalog, foreign_data_wrapper_name, authorization_identifier, library_name, foreign_data_wrapper_language) AS  SELECT w.foreign_data_wrapper_catalog,
    w.foreign_data_wrapper_name,
    w.authorization_identifier,
    (NULL::character varying)::character_data AS library_name,
    w.foreign_data_wrapper_language
   FROM _pg_foreign_data_wrappers w;
DROP VIEW foreign_server_options;
CREATE VIEW foreign_server_options (foreign_server_catalog, foreign_server_name, option_name, option_value) AS  SELECT s.foreign_server_catalog,
    s.foreign_server_name,
    ((pg_options_to_table(s.srvoptions)).option_name)::sql_identifier AS option_name,
    ((pg_options_to_table(s.srvoptions)).option_value)::character_data AS option_value
   FROM _pg_foreign_servers s;
DROP VIEW foreign_servers;
CREATE VIEW foreign_servers (foreign_server_catalog, foreign_server_name, foreign_data_wrapper_catalog, foreign_data_wrapper_name, foreign_server_type, foreign_server_version, authorization_identifier) AS  SELECT _pg_foreign_servers.foreign_server_catalog,
    _pg_foreign_servers.foreign_server_name,
    _pg_foreign_servers.foreign_data_wrapper_catalog,
    _pg_foreign_servers.foreign_data_wrapper_name,
    _pg_foreign_servers.foreign_server_type,
    _pg_foreign_servers.foreign_server_version,
    _pg_foreign_servers.authorization_identifier
   FROM _pg_foreign_servers;
DROP VIEW foreign_table_options;
CREATE VIEW foreign_table_options (foreign_table_catalog, foreign_table_schema, foreign_table_name, option_name, option_value) AS  SELECT t.foreign_table_catalog,
    t.foreign_table_schema,
    t.foreign_table_name,
    ((pg_options_to_table(t.ftoptions)).option_name)::sql_identifier AS option_name,
    ((pg_options_to_table(t.ftoptions)).option_value)::character_data AS option_value
   FROM _pg_foreign_tables t;
DROP VIEW foreign_tables;
CREATE VIEW foreign_tables (foreign_table_catalog, foreign_table_schema, foreign_table_name, foreign_server_catalog, foreign_server_name) AS  SELECT _pg_foreign_tables.foreign_table_catalog,
    _pg_foreign_tables.foreign_table_schema,
    _pg_foreign_tables.foreign_table_name,
    _pg_foreign_tables.foreign_server_catalog,
    _pg_foreign_tables.foreign_server_name
   FROM _pg_foreign_tables;
DROP VIEW information_schema_catalog_name;
CREATE VIEW information_schema_catalog_name (catalog_name) AS  SELECT (current_database())::sql_identifier AS catalog_name;
DROP VIEW key_column_usage;
CREATE VIEW key_column_usage (constraint_catalog, constraint_schema, constraint_name, table_catalog, table_schema, table_name, column_name, ordinal_position, position_in_unique_constraint) AS  SELECT (current_database())::sql_identifier AS constraint_catalog,
    (ss.nc_nspname)::sql_identifier AS constraint_schema,
    (ss.conname)::sql_identifier AS constraint_name,
    (current_database())::sql_identifier AS table_catalog,
    (ss.nr_nspname)::sql_identifier AS table_schema,
    (ss.relname)::sql_identifier AS table_name,
    (a.attname)::sql_identifier AS column_name,
    ((ss.x).n)::cardinal_number AS ordinal_position,
    (
        CASE
            WHEN (ss.contype = 'f'::"char") THEN _pg_index_position(ss.conindid, ss.confkey[(ss.x).n])
            ELSE NULL::integer
        END)::cardinal_number AS position_in_unique_constraint
   FROM pg_attribute a,
    ( SELECT r.oid AS roid,
            r.relname,
            r.relowner,
            nc.nspname AS nc_nspname,
            nr.nspname AS nr_nspname,
            c.oid AS coid,
            c.conname,
            c.contype,
            c.conindid,
            c.confkey,
            c.confrelid,
            _pg_expandarray(c.conkey) AS x
           FROM pg_namespace nr,
            pg_class r,
            pg_namespace nc,
            pg_constraint c
          WHERE ((nr.oid = r.relnamespace) AND (r.oid = c.conrelid) AND (nc.oid = c.connamespace) AND (c.contype = ANY (ARRAY['p'::"char", 'u'::"char", 'f'::"char"])) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND (NOT pg_is_other_temp_schema(nr.oid)))) ss
  WHERE ((ss.roid = a.attrelid) AND (a.attnum = (ss.x).x) AND (NOT a.attisdropped) AND (pg_has_role(ss.relowner, 'USAGE'::text) OR has_column_privilege(ss.roid, a.attnum, 'SELECT, INSERT, UPDATE, REFERENCES'::text)));
DROP VIEW parameters;
CREATE VIEW parameters (specific_catalog, specific_schema, specific_name, ordinal_position, parameter_mode, is_result, as_locator, parameter_name, data_type, character_maximum_length, character_octet_length, character_set_catalog, character_set_schema, character_set_name, collation_catalog, collation_schema, collation_name, numeric_precision, numeric_precision_radix, numeric_scale, datetime_precision, interval_type, interval_precision, udt_catalog, udt_schema, udt_name, scope_catalog, scope_schema, scope_name, maximum_cardinality, dtd_identifier, parameter_default) AS  SELECT (current_database())::sql_identifier AS specific_catalog,
    (ss.n_nspname)::sql_identifier AS specific_schema,
    ((((ss.proname)::text || '_'::text) || (ss.p_oid)::text))::sql_identifier AS specific_name,
    ((ss.x).n)::cardinal_number AS ordinal_position,
    (
        CASE
            WHEN (ss.proargmodes IS NULL) THEN 'IN'::text
            WHEN (ss.proargmodes[(ss.x).n] = 'i'::"char") THEN 'IN'::text
            WHEN (ss.proargmodes[(ss.x).n] = 'o'::"char") THEN 'OUT'::text
            WHEN (ss.proargmodes[(ss.x).n] = 'b'::"char") THEN 'INOUT'::text
            WHEN (ss.proargmodes[(ss.x).n] = 'v'::"char") THEN 'IN'::text
            WHEN (ss.proargmodes[(ss.x).n] = 't'::"char") THEN 'OUT'::text
            ELSE NULL::text
        END)::character_data AS parameter_mode,
    ('NO'::character varying)::yes_or_no AS is_result,
    ('NO'::character varying)::yes_or_no AS as_locator,
    (NULLIF(ss.proargnames[(ss.x).n], ''::text))::sql_identifier AS parameter_name,
    (
        CASE
            WHEN ((t.typelem <> (0)::oid) AND (t.typlen = '-1'::integer)) THEN 'ARRAY'::text
            WHEN (nt.nspname = 'pg_catalog'::name) THEN format_type(t.oid, NULL::integer)
            ELSE 'USER-DEFINED'::text
        END)::character_data AS data_type,
    (NULL::integer)::cardinal_number AS character_maximum_length,
    (NULL::integer)::cardinal_number AS character_octet_length,
    (NULL::character varying)::sql_identifier AS character_set_catalog,
    (NULL::character varying)::sql_identifier AS character_set_schema,
    (NULL::character varying)::sql_identifier AS character_set_name,
    (NULL::character varying)::sql_identifier AS collation_catalog,
    (NULL::character varying)::sql_identifier AS collation_schema,
    (NULL::character varying)::sql_identifier AS collation_name,
    (NULL::integer)::cardinal_number AS numeric_precision,
    (NULL::integer)::cardinal_number AS numeric_precision_radix,
    (NULL::integer)::cardinal_number AS numeric_scale,
    (NULL::integer)::cardinal_number AS datetime_precision,
    (NULL::character varying)::character_data AS interval_type,
    (NULL::integer)::cardinal_number AS interval_precision,
    (current_database())::sql_identifier AS udt_catalog,
    (nt.nspname)::sql_identifier AS udt_schema,
    (t.typname)::sql_identifier AS udt_name,
    (NULL::character varying)::sql_identifier AS scope_catalog,
    (NULL::character varying)::sql_identifier AS scope_schema,
    (NULL::character varying)::sql_identifier AS scope_name,
    (NULL::integer)::cardinal_number AS maximum_cardinality,
    ((ss.x).n)::sql_identifier AS dtd_identifier,
    (
        CASE
            WHEN pg_has_role(ss.proowner, 'USAGE'::text) THEN pg_get_function_arg_default(ss.p_oid, (ss.x).n)
            ELSE NULL::text
        END)::character_data AS parameter_default
   FROM pg_type t,
    pg_namespace nt,
    ( SELECT n.nspname AS n_nspname,
            p.proname,
            p.oid AS p_oid,
            p.proowner,
            p.proargnames,
            p.proargmodes,
            _pg_expandarray(COALESCE(p.proallargtypes, (p.proargtypes)::oid[])) AS x
           FROM pg_namespace n,
            pg_proc p
          WHERE ((n.oid = p.pronamespace) AND (pg_has_role(p.proowner, 'USAGE'::text) OR has_function_privilege(p.oid, 'EXECUTE'::text)))) ss
  WHERE ((t.oid = (ss.x).x) AND (t.typnamespace = nt.oid));
DROP VIEW referential_constraints;
CREATE VIEW referential_constraints (constraint_catalog, constraint_schema, constraint_name, unique_constraint_catalog, unique_constraint_schema, unique_constraint_name, match_option, update_rule, delete_rule) AS  SELECT (current_database())::sql_identifier AS constraint_catalog,
    (ncon.nspname)::sql_identifier AS constraint_schema,
    (con.conname)::sql_identifier AS constraint_name,
    (
        CASE
            WHEN (npkc.nspname IS NULL) THEN NULL::name
            ELSE current_database()
        END)::sql_identifier AS unique_constraint_catalog,
    (npkc.nspname)::sql_identifier AS unique_constraint_schema,
    (pkc.conname)::sql_identifier AS unique_constraint_name,
    (
        CASE con.confmatchtype
            WHEN 'f'::"char" THEN 'FULL'::text
            WHEN 'p'::"char" THEN 'PARTIAL'::text
            WHEN 's'::"char" THEN 'NONE'::text
            ELSE NULL::text
        END)::character_data AS match_option,
    (
        CASE con.confupdtype
            WHEN 'c'::"char" THEN 'CASCADE'::text
            WHEN 'n'::"char" THEN 'SET NULL'::text
            WHEN 'd'::"char" THEN 'SET DEFAULT'::text
            WHEN 'r'::"char" THEN 'RESTRICT'::text
            WHEN 'a'::"char" THEN 'NO ACTION'::text
            ELSE NULL::text
        END)::character_data AS update_rule,
    (
        CASE con.confdeltype
            WHEN 'c'::"char" THEN 'CASCADE'::text
            WHEN 'n'::"char" THEN 'SET NULL'::text
            WHEN 'd'::"char" THEN 'SET DEFAULT'::text
            WHEN 'r'::"char" THEN 'RESTRICT'::text
            WHEN 'a'::"char" THEN 'NO ACTION'::text
            ELSE NULL::text
        END)::character_data AS delete_rule
   FROM ((((((pg_namespace ncon
     JOIN pg_constraint con ON ((ncon.oid = con.connamespace)))
     JOIN pg_class c ON (((con.conrelid = c.oid) AND (con.contype = 'f'::"char"))))
     LEFT JOIN pg_depend d1 ON (((d1.objid = con.oid) AND (d1.classid = ('pg_constraint'::regclass)::oid) AND (d1.refclassid = ('pg_class'::regclass)::oid) AND (d1.refobjsubid = 0))))
     LEFT JOIN pg_depend d2 ON (((d2.refclassid = ('pg_constraint'::regclass)::oid) AND (d2.classid = ('pg_class'::regclass)::oid) AND (d2.objid = d1.refobjid) AND (d2.objsubid = 0) AND (d2.deptype = 'i'::"char"))))
     LEFT JOIN pg_constraint pkc ON (((pkc.oid = d2.refobjid) AND (pkc.contype = ANY (ARRAY['p'::"char", 'u'::"char"])) AND (pkc.conrelid = con.confrelid))))
     LEFT JOIN pg_namespace npkc ON ((pkc.connamespace = npkc.oid)))
  WHERE (pg_has_role(c.relowner, 'USAGE'::text) OR has_table_privilege(c.oid, 'INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(c.oid, 'INSERT, UPDATE, REFERENCES'::text));
DROP VIEW role_column_grants;
CREATE VIEW role_column_grants (grantor, grantee, table_catalog, table_schema, table_name, column_name, privilege_type, is_grantable) AS  SELECT column_privileges.grantor,
    column_privileges.grantee,
    column_privileges.table_catalog,
    column_privileges.table_schema,
    column_privileges.table_name,
    column_privileges.column_name,
    column_privileges.privilege_type,
    column_privileges.is_grantable
   FROM column_privileges
  WHERE (((column_privileges.grantor)::text IN ( SELECT enabled_roles.role_name
           FROM enabled_roles)) OR ((column_privileges.grantee)::text IN ( SELECT enabled_roles.role_name
           FROM enabled_roles)));
DROP VIEW role_routine_grants;
CREATE VIEW role_routine_grants (grantor, grantee, specific_catalog, specific_schema, specific_name, routine_catalog, routine_schema, routine_name, privilege_type, is_grantable) AS  SELECT routine_privileges.grantor,
    routine_privileges.grantee,
    routine_privileges.specific_catalog,
    routine_privileges.specific_schema,
    routine_privileges.specific_name,
    routine_privileges.routine_catalog,
    routine_privileges.routine_schema,
    routine_privileges.routine_name,
    routine_privileges.privilege_type,
    routine_privileges.is_grantable
   FROM routine_privileges
  WHERE (((routine_privileges.grantor)::text IN ( SELECT enabled_roles.role_name
           FROM enabled_roles)) OR ((routine_privileges.grantee)::text IN ( SELECT enabled_roles.role_name
           FROM enabled_roles)));
DROP VIEW role_table_grants;
CREATE VIEW role_table_grants (grantor, grantee, table_catalog, table_schema, table_name, privilege_type, is_grantable, with_hierarchy) AS  SELECT table_privileges.grantor,
    table_privileges.grantee,
    table_privileges.table_catalog,
    table_privileges.table_schema,
    table_privileges.table_name,
    table_privileges.privilege_type,
    table_privileges.is_grantable,
    table_privileges.with_hierarchy
   FROM table_privileges
  WHERE (((table_privileges.grantor)::text IN ( SELECT enabled_roles.role_name
           FROM enabled_roles)) OR ((table_privileges.grantee)::text IN ( SELECT enabled_roles.role_name
           FROM enabled_roles)));
DROP VIEW role_udt_grants;
CREATE VIEW role_udt_grants (grantor, grantee, udt_catalog, udt_schema, udt_name, privilege_type, is_grantable) AS  SELECT udt_privileges.grantor,
    udt_privileges.grantee,
    udt_privileges.udt_catalog,
    udt_privileges.udt_schema,
    udt_privileges.udt_name,
    udt_privileges.privilege_type,
    udt_privileges.is_grantable
   FROM udt_privileges
  WHERE (((udt_privileges.grantor)::text IN ( SELECT enabled_roles.role_name
           FROM enabled_roles)) OR ((udt_privileges.grantee)::text IN ( SELECT enabled_roles.role_name
           FROM enabled_roles)));
DROP VIEW role_usage_grants;
CREATE VIEW role_usage_grants (grantor, grantee, object_catalog, object_schema, object_name, object_type, privilege_type, is_grantable) AS  SELECT usage_privileges.grantor,
    usage_privileges.grantee,
    usage_privileges.object_catalog,
    usage_privileges.object_schema,
    usage_privileges.object_name,
    usage_privileges.object_type,
    usage_privileges.privilege_type,
    usage_privileges.is_grantable
   FROM usage_privileges
  WHERE (((usage_privileges.grantor)::text IN ( SELECT enabled_roles.role_name
           FROM enabled_roles)) OR ((usage_privileges.grantee)::text IN ( SELECT enabled_roles.role_name
           FROM enabled_roles)));
DROP VIEW routine_privileges;
CREATE VIEW routine_privileges (grantor, grantee, specific_catalog, specific_schema, specific_name, routine_catalog, routine_schema, routine_name, privilege_type, is_grantable) AS  SELECT (u_grantor.rolname)::sql_identifier AS grantor,
    (grantee.rolname)::sql_identifier AS grantee,
    (current_database())::sql_identifier AS specific_catalog,
    (n.nspname)::sql_identifier AS specific_schema,
    ((((p.proname)::text || '_'::text) || (p.oid)::text))::sql_identifier AS specific_name,
    (current_database())::sql_identifier AS routine_catalog,
    (n.nspname)::sql_identifier AS routine_schema,
    (p.proname)::sql_identifier AS routine_name,
    ('EXECUTE'::character varying)::character_data AS privilege_type,
    (
        CASE
            WHEN (pg_has_role(grantee.oid, p.proowner, 'USAGE'::text) OR p.grantable) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_grantable
   FROM ( SELECT pg_proc.oid,
            pg_proc.proname,
            pg_proc.proowner,
            pg_proc.pronamespace,
            (aclexplode(COALESCE(pg_proc.proacl, acldefault('f'::"char", pg_proc.proowner)))).grantor AS grantor,
            (aclexplode(COALESCE(pg_proc.proacl, acldefault('f'::"char", pg_proc.proowner)))).grantee AS grantee,
            (aclexplode(COALESCE(pg_proc.proacl, acldefault('f'::"char", pg_proc.proowner)))).privilege_type AS privilege_type,
            (aclexplode(COALESCE(pg_proc.proacl, acldefault('f'::"char", pg_proc.proowner)))).is_grantable AS is_grantable
           FROM pg_proc) p(oid, proname, proowner, pronamespace, grantor, grantee, prtype, grantable),
    pg_namespace n,
    pg_authid u_grantor,
    ( SELECT pg_authid.oid,
            pg_authid.rolname
           FROM pg_authid
        UNION ALL
         SELECT (0)::oid AS oid,
            'PUBLIC'::name) grantee(oid, rolname)
  WHERE ((p.pronamespace = n.oid) AND (grantee.oid = p.grantee) AND (u_grantor.oid = p.grantor) AND (p.prtype = 'EXECUTE'::text) AND (pg_has_role(u_grantor.oid, 'USAGE'::text) OR pg_has_role(grantee.oid, 'USAGE'::text) OR (grantee.rolname = 'PUBLIC'::name)));
DROP VIEW routines;
CREATE VIEW routines (specific_catalog, specific_schema, specific_name, routine_catalog, routine_schema, routine_name, routine_type, module_catalog, module_schema, module_name, udt_catalog, udt_schema, udt_name, data_type, character_maximum_length, character_octet_length, character_set_catalog, character_set_schema, character_set_name, collation_catalog, collation_schema, collation_name, numeric_precision, numeric_precision_radix, numeric_scale, datetime_precision, interval_type, interval_precision, type_udt_catalog, type_udt_schema, type_udt_name, scope_catalog, scope_schema, scope_name, maximum_cardinality, dtd_identifier, routine_body, routine_definition, external_name, external_language, parameter_style, is_deterministic, sql_data_access, is_null_call, sql_path, schema_level_routine, max_dynamic_result_sets, is_user_defined_cast, is_implicitly_invocable, security_type, to_sql_specific_catalog, to_sql_specific_schema, to_sql_specific_name, as_locator, created, last_altered, new_savepoint_level, is_udt_dependent, result_cast_from_data_type, result_cast_as_locator, result_cast_char_max_length, result_cast_char_octet_length, result_cast_char_set_catalog, result_cast_char_set_schema, result_cast_char_set_name, result_cast_collation_catalog, result_cast_collation_schema, result_cast_collation_name, result_cast_numeric_precision, result_cast_numeric_precision_radix, result_cast_numeric_scale, result_cast_datetime_precision, result_cast_interval_type, result_cast_interval_precision, result_cast_type_udt_catalog, result_cast_type_udt_schema, result_cast_type_udt_name, result_cast_scope_catalog, result_cast_scope_schema, result_cast_scope_name, result_cast_maximum_cardinality, result_cast_dtd_identifier) AS  SELECT (current_database())::sql_identifier AS specific_catalog,
    (n.nspname)::sql_identifier AS specific_schema,
    ((((p.proname)::text || '_'::text) || (p.oid)::text))::sql_identifier AS specific_name,
    (current_database())::sql_identifier AS routine_catalog,
    (n.nspname)::sql_identifier AS routine_schema,
    (p.proname)::sql_identifier AS routine_name,
    (
        CASE p.prokind
            WHEN 'f'::"char" THEN 'FUNCTION'::text
            WHEN 'p'::"char" THEN 'PROCEDURE'::text
            ELSE NULL::text
        END)::character_data AS routine_type,
    (NULL::character varying)::sql_identifier AS module_catalog,
    (NULL::character varying)::sql_identifier AS module_schema,
    (NULL::character varying)::sql_identifier AS module_name,
    (NULL::character varying)::sql_identifier AS udt_catalog,
    (NULL::character varying)::sql_identifier AS udt_schema,
    (NULL::character varying)::sql_identifier AS udt_name,
    (
        CASE
            WHEN (p.prokind = 'p'::"char") THEN NULL::text
            WHEN ((t.typelem <> (0)::oid) AND (t.typlen = '-1'::integer)) THEN 'ARRAY'::text
            WHEN (nt.nspname = 'pg_catalog'::name) THEN format_type(t.oid, NULL::integer)
            ELSE 'USER-DEFINED'::text
        END)::character_data AS data_type,
    (NULL::integer)::cardinal_number AS character_maximum_length,
    (NULL::integer)::cardinal_number AS character_octet_length,
    (NULL::character varying)::sql_identifier AS character_set_catalog,
    (NULL::character varying)::sql_identifier AS character_set_schema,
    (NULL::character varying)::sql_identifier AS character_set_name,
    (NULL::character varying)::sql_identifier AS collation_catalog,
    (NULL::character varying)::sql_identifier AS collation_schema,
    (NULL::character varying)::sql_identifier AS collation_name,
    (NULL::integer)::cardinal_number AS numeric_precision,
    (NULL::integer)::cardinal_number AS numeric_precision_radix,
    (NULL::integer)::cardinal_number AS numeric_scale,
    (NULL::integer)::cardinal_number AS datetime_precision,
    (NULL::character varying)::character_data AS interval_type,
    (NULL::integer)::cardinal_number AS interval_precision,
    (
        CASE
            WHEN (nt.nspname IS NOT NULL) THEN current_database()
            ELSE NULL::name
        END)::sql_identifier AS type_udt_catalog,
    (nt.nspname)::sql_identifier AS type_udt_schema,
    (t.typname)::sql_identifier AS type_udt_name,
    (NULL::character varying)::sql_identifier AS scope_catalog,
    (NULL::character varying)::sql_identifier AS scope_schema,
    (NULL::character varying)::sql_identifier AS scope_name,
    (NULL::integer)::cardinal_number AS maximum_cardinality,
    (
        CASE
            WHEN (p.prokind <> 'p'::"char") THEN 0
            ELSE NULL::integer
        END)::sql_identifier AS dtd_identifier,
    (
        CASE
            WHEN (l.lanname = 'sql'::name) THEN 'SQL'::text
            ELSE 'EXTERNAL'::text
        END)::character_data AS routine_body,
    (
        CASE
            WHEN pg_has_role(p.proowner, 'USAGE'::text) THEN p.prosrc
            ELSE NULL::text
        END)::character_data AS routine_definition,
    (
        CASE
            WHEN (l.lanname = 'c'::name) THEN p.prosrc
            ELSE NULL::text
        END)::character_data AS external_name,
    (upper((l.lanname)::text))::character_data AS external_language,
    ('GENERAL'::character varying)::character_data AS parameter_style,
    (
        CASE
            WHEN (p.provolatile = 'i'::"char") THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_deterministic,
    ('MODIFIES'::character varying)::character_data AS sql_data_access,
    (
        CASE
            WHEN (p.prokind <> 'p'::"char") THEN
            CASE
                WHEN p.proisstrict THEN 'YES'::text
                ELSE 'NO'::text
            END
            ELSE NULL::text
        END)::yes_or_no AS is_null_call,
    (NULL::character varying)::character_data AS sql_path,
    ('YES'::character varying)::yes_or_no AS schema_level_routine,
    (0)::cardinal_number AS max_dynamic_result_sets,
    (NULL::character varying)::yes_or_no AS is_user_defined_cast,
    (NULL::character varying)::yes_or_no AS is_implicitly_invocable,
    (
        CASE
            WHEN p.prosecdef THEN 'DEFINER'::text
            ELSE 'INVOKER'::text
        END)::character_data AS security_type,
    (NULL::character varying)::sql_identifier AS to_sql_specific_catalog,
    (NULL::character varying)::sql_identifier AS to_sql_specific_schema,
    (NULL::character varying)::sql_identifier AS to_sql_specific_name,
    ('NO'::character varying)::yes_or_no AS as_locator,
    (NULL::timestamp with time zone)::time_stamp AS created,
    (NULL::timestamp with time zone)::time_stamp AS last_altered,
    (NULL::character varying)::yes_or_no AS new_savepoint_level,
    ('NO'::character varying)::yes_or_no AS is_udt_dependent,
    (NULL::character varying)::character_data AS result_cast_from_data_type,
    (NULL::character varying)::yes_or_no AS result_cast_as_locator,
    (NULL::integer)::cardinal_number AS result_cast_char_max_length,
    (NULL::integer)::cardinal_number AS result_cast_char_octet_length,
    (NULL::character varying)::sql_identifier AS result_cast_char_set_catalog,
    (NULL::character varying)::sql_identifier AS result_cast_char_set_schema,
    (NULL::character varying)::sql_identifier AS result_cast_char_set_name,
    (NULL::character varying)::sql_identifier AS result_cast_collation_catalog,
    (NULL::character varying)::sql_identifier AS result_cast_collation_schema,
    (NULL::character varying)::sql_identifier AS result_cast_collation_name,
    (NULL::integer)::cardinal_number AS result_cast_numeric_precision,
    (NULL::integer)::cardinal_number AS result_cast_numeric_precision_radix,
    (NULL::integer)::cardinal_number AS result_cast_numeric_scale,
    (NULL::integer)::cardinal_number AS result_cast_datetime_precision,
    (NULL::character varying)::character_data AS result_cast_interval_type,
    (NULL::integer)::cardinal_number AS result_cast_interval_precision,
    (NULL::character varying)::sql_identifier AS result_cast_type_udt_catalog,
    (NULL::character varying)::sql_identifier AS result_cast_type_udt_schema,
    (NULL::character varying)::sql_identifier AS result_cast_type_udt_name,
    (NULL::character varying)::sql_identifier AS result_cast_scope_catalog,
    (NULL::character varying)::sql_identifier AS result_cast_scope_schema,
    (NULL::character varying)::sql_identifier AS result_cast_scope_name,
    (NULL::integer)::cardinal_number AS result_cast_maximum_cardinality,
    (NULL::character varying)::sql_identifier AS result_cast_dtd_identifier
   FROM (((pg_namespace n
     JOIN pg_proc p ON ((n.oid = p.pronamespace)))
     JOIN pg_language l ON ((p.prolang = l.oid)))
     LEFT JOIN (pg_type t
     JOIN pg_namespace nt ON ((t.typnamespace = nt.oid))) ON (((p.prorettype = t.oid) AND (p.prokind <> 'p'::"char"))))
  WHERE (pg_has_role(p.proowner, 'USAGE'::text) OR has_function_privilege(p.oid, 'EXECUTE'::text));
DROP VIEW schemata;
CREATE VIEW schemata (catalog_name, schema_name, schema_owner, default_character_set_catalog, default_character_set_schema, default_character_set_name, sql_path) AS  SELECT (current_database())::sql_identifier AS catalog_name,
    (n.nspname)::sql_identifier AS schema_name,
    (u.rolname)::sql_identifier AS schema_owner,
    (NULL::character varying)::sql_identifier AS default_character_set_catalog,
    (NULL::character varying)::sql_identifier AS default_character_set_schema,
    (NULL::character varying)::sql_identifier AS default_character_set_name,
    (NULL::character varying)::character_data AS sql_path
   FROM pg_namespace n,
    pg_authid u
  WHERE ((n.nspowner = u.oid) AND (pg_has_role(n.nspowner, 'USAGE'::text) OR has_schema_privilege(n.oid, 'CREATE, USAGE'::text)));
DROP VIEW sequences;
CREATE VIEW sequences (sequence_catalog, sequence_schema, sequence_name, data_type, numeric_precision, numeric_precision_radix, numeric_scale, start_value, minimum_value, maximum_value, increment, cycle_option) AS  SELECT (current_database())::sql_identifier AS sequence_catalog,
    (nc.nspname)::sql_identifier AS sequence_schema,
    (c.relname)::sql_identifier AS sequence_name,
    (format_type(s.seqtypid, NULL::integer))::character_data AS data_type,
    (_pg_numeric_precision(s.seqtypid, '-1'::integer))::cardinal_number AS numeric_precision,
    (2)::cardinal_number AS numeric_precision_radix,
    (0)::cardinal_number AS numeric_scale,
    (s.seqstart)::character_data AS start_value,
    (s.seqmin)::character_data AS minimum_value,
    (s.seqmax)::character_data AS maximum_value,
    (s.seqincrement)::character_data AS increment,
    (
        CASE
            WHEN s.seqcycle THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS cycle_option
   FROM pg_namespace nc,
    pg_class c,
    pg_sequence s
  WHERE ((c.relnamespace = nc.oid) AND (c.relkind = 'S'::"char") AND (NOT (EXISTS ( SELECT 1
           FROM pg_depend
          WHERE ((pg_depend.classid = ('pg_class'::regclass)::oid) AND (pg_depend.objid = c.oid) AND (pg_depend.deptype = 'i'::"char"))))) AND (NOT pg_is_other_temp_schema(nc.oid)) AND (c.oid = s.seqrelid) AND (pg_has_role(c.relowner, 'USAGE'::text) OR has_sequence_privilege(c.oid, 'SELECT, UPDATE, USAGE'::text)));
DROP VIEW table_constraints;
CREATE VIEW table_constraints (constraint_catalog, constraint_schema, constraint_name, table_catalog, table_schema, table_name, constraint_type, is_deferrable, initially_deferred, enforced) AS  SELECT (current_database())::sql_identifier AS constraint_catalog,
    (nc.nspname)::sql_identifier AS constraint_schema,
    (c.conname)::sql_identifier AS constraint_name,
    (current_database())::sql_identifier AS table_catalog,
    (nr.nspname)::sql_identifier AS table_schema,
    (r.relname)::sql_identifier AS table_name,
    (
        CASE c.contype
            WHEN 'c'::"char" THEN 'CHECK'::text
            WHEN 'f'::"char" THEN 'FOREIGN KEY'::text
            WHEN 'p'::"char" THEN 'PRIMARY KEY'::text
            WHEN 'u'::"char" THEN 'UNIQUE'::text
            ELSE NULL::text
        END)::character_data AS constraint_type,
    (
        CASE
            WHEN c.condeferrable THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_deferrable,
    (
        CASE
            WHEN c.condeferred THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS initially_deferred,
    ('YES'::character varying)::yes_or_no AS enforced
   FROM pg_namespace nc,
    pg_namespace nr,
    pg_constraint c,
    pg_class r
  WHERE ((nc.oid = c.connamespace) AND (nr.oid = r.relnamespace) AND (c.conrelid = r.oid) AND (c.contype <> ALL (ARRAY['t'::"char", 'x'::"char"])) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND (NOT pg_is_other_temp_schema(nr.oid)) AND (pg_has_role(r.relowner, 'USAGE'::text) OR has_table_privilege(r.oid, 'INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(r.oid, 'INSERT, UPDATE, REFERENCES'::text)))
UNION ALL
 SELECT (current_database())::sql_identifier AS constraint_catalog,
    (nr.nspname)::sql_identifier AS constraint_schema,
    (((((((nr.oid)::text || '_'::text) || (r.oid)::text) || '_'::text) || (a.attnum)::text) || '_not_null'::text))::sql_identifier AS constraint_name,
    (current_database())::sql_identifier AS table_catalog,
    (nr.nspname)::sql_identifier AS table_schema,
    (r.relname)::sql_identifier AS table_name,
    ('CHECK'::character varying)::character_data AS constraint_type,
    ('NO'::character varying)::yes_or_no AS is_deferrable,
    ('NO'::character varying)::yes_or_no AS initially_deferred,
    ('YES'::character varying)::yes_or_no AS enforced
   FROM pg_namespace nr,
    pg_class r,
    pg_attribute a
  WHERE ((nr.oid = r.relnamespace) AND (r.oid = a.attrelid) AND a.attnotnull AND (a.attnum > 0) AND (NOT a.attisdropped) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND (NOT pg_is_other_temp_schema(nr.oid)) AND (pg_has_role(r.relowner, 'USAGE'::text) OR has_table_privilege(r.oid, 'INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(r.oid, 'INSERT, UPDATE, REFERENCES'::text)));
DROP VIEW table_privileges;
CREATE VIEW table_privileges (grantor, grantee, table_catalog, table_schema, table_name, privilege_type, is_grantable, with_hierarchy) AS  SELECT (u_grantor.rolname)::sql_identifier AS grantor,
    (grantee.rolname)::sql_identifier AS grantee,
    (current_database())::sql_identifier AS table_catalog,
    (nc.nspname)::sql_identifier AS table_schema,
    (c.relname)::sql_identifier AS table_name,
    (c.prtype)::character_data AS privilege_type,
    (
        CASE
            WHEN (pg_has_role(grantee.oid, c.relowner, 'USAGE'::text) OR c.grantable) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_grantable,
    (
        CASE
            WHEN (c.prtype = 'SELECT'::text) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS with_hierarchy
   FROM ( SELECT pg_class.oid,
            pg_class.relname,
            pg_class.relnamespace,
            pg_class.relkind,
            pg_class.relowner,
            (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).grantor AS grantor,
            (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).grantee AS grantee,
            (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).privilege_type AS privilege_type,
            (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).is_grantable AS is_grantable
           FROM pg_class) c(oid, relname, relnamespace, relkind, relowner, grantor, grantee, prtype, grantable),
    pg_namespace nc,
    pg_authid u_grantor,
    ( SELECT pg_authid.oid,
            pg_authid.rolname
           FROM pg_authid
        UNION ALL
         SELECT (0)::oid AS oid,
            'PUBLIC'::name) grantee(oid, rolname)
  WHERE ((c.relnamespace = nc.oid) AND (c.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'f'::"char", 'p'::"char"])) AND (c.grantee = grantee.oid) AND (c.grantor = u_grantor.oid) AND (c.prtype = ANY (ARRAY['INSERT'::text, 'SELECT'::text, 'UPDATE'::text, 'DELETE'::text, 'TRUNCATE'::text, 'REFERENCES'::text, 'TRIGGER'::text])) AND (pg_has_role(u_grantor.oid, 'USAGE'::text) OR pg_has_role(grantee.oid, 'USAGE'::text) OR (grantee.rolname = 'PUBLIC'::name)));
DROP VIEW tables;
CREATE VIEW tables (table_catalog, table_schema, table_name, table_type, self_referencing_column_name, reference_generation, user_defined_type_catalog, user_defined_type_schema, user_defined_type_name, is_insertable_into, is_typed, commit_action) AS  SELECT (current_database())::sql_identifier AS table_catalog,
    (nc.nspname)::sql_identifier AS table_schema,
    (c.relname)::sql_identifier AS table_name,
    (
        CASE
            WHEN (nc.oid = pg_my_temp_schema()) THEN 'LOCAL TEMPORARY'::text
            WHEN (c.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) THEN 'BASE TABLE'::text
            WHEN (c.relkind = 'v'::"char") THEN 'VIEW'::text
            WHEN (c.relkind = 'f'::"char") THEN 'FOREIGN'::text
            ELSE NULL::text
        END)::character_data AS table_type,
    (NULL::character varying)::sql_identifier AS self_referencing_column_name,
    (NULL::character varying)::character_data AS reference_generation,
    (
        CASE
            WHEN (t.typname IS NOT NULL) THEN current_database()
            ELSE NULL::name
        END)::sql_identifier AS user_defined_type_catalog,
    (nt.nspname)::sql_identifier AS user_defined_type_schema,
    (t.typname)::sql_identifier AS user_defined_type_name,
    (
        CASE
            WHEN ((c.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) OR ((c.relkind = ANY (ARRAY['v'::"char", 'f'::"char"])) AND ((pg_relation_is_updatable((c.oid)::regclass, false) & 8) = 8))) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_insertable_into,
    (
        CASE
            WHEN (t.typname IS NOT NULL) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_typed,
    (NULL::character varying)::character_data AS commit_action
   FROM ((pg_namespace nc
     JOIN pg_class c ON ((nc.oid = c.relnamespace)))
     LEFT JOIN (pg_type t
     JOIN pg_namespace nt ON ((t.typnamespace = nt.oid))) ON ((c.reloftype = t.oid)))
  WHERE ((c.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'f'::"char", 'p'::"char"])) AND (NOT pg_is_other_temp_schema(nc.oid)) AND (pg_has_role(c.relowner, 'USAGE'::text) OR has_table_privilege(c.oid, 'SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(c.oid, 'SELECT, INSERT, UPDATE, REFERENCES'::text)));
DROP VIEW transforms;
CREATE VIEW transforms (udt_catalog, udt_schema, udt_name, specific_catalog, specific_schema, specific_name, group_name, transform_type) AS  SELECT (current_database())::sql_identifier AS udt_catalog,
    (nt.nspname)::sql_identifier AS udt_schema,
    (t.typname)::sql_identifier AS udt_name,
    (current_database())::sql_identifier AS specific_catalog,
    (np.nspname)::sql_identifier AS specific_schema,
    ((((p.proname)::text || '_'::text) || (p.oid)::text))::sql_identifier AS specific_name,
    (l.lanname)::sql_identifier AS group_name,
    ('FROM SQL'::character varying)::character_data AS transform_type
   FROM (((((pg_type t
     JOIN pg_transform x ON ((t.oid = x.trftype)))
     JOIN pg_language l ON ((x.trflang = l.oid)))
     JOIN pg_proc p ON (((x.trffromsql)::oid = p.oid)))
     JOIN pg_namespace nt ON ((t.typnamespace = nt.oid)))
     JOIN pg_namespace np ON ((p.pronamespace = np.oid)))
UNION
 SELECT (current_database())::sql_identifier AS udt_catalog,
    (nt.nspname)::sql_identifier AS udt_schema,
    (t.typname)::sql_identifier AS udt_name,
    (current_database())::sql_identifier AS specific_catalog,
    (np.nspname)::sql_identifier AS specific_schema,
    ((((p.proname)::text || '_'::text) || (p.oid)::text))::sql_identifier AS specific_name,
    (l.lanname)::sql_identifier AS group_name,
    ('TO SQL'::character varying)::character_data AS transform_type
   FROM (((((pg_type t
     JOIN pg_transform x ON ((t.oid = x.trftype)))
     JOIN pg_language l ON ((x.trflang = l.oid)))
     JOIN pg_proc p ON (((x.trftosql)::oid = p.oid)))
     JOIN pg_namespace nt ON ((t.typnamespace = nt.oid)))
     JOIN pg_namespace np ON ((p.pronamespace = np.oid)))
  ORDER BY 1, 2, 3, 7, 8;
DROP VIEW triggered_update_columns;
CREATE VIEW triggered_update_columns (trigger_catalog, trigger_schema, trigger_name, event_object_catalog, event_object_schema, event_object_table, event_object_column) AS  SELECT (current_database())::sql_identifier AS trigger_catalog,
    (n.nspname)::sql_identifier AS trigger_schema,
    (t.tgname)::sql_identifier AS trigger_name,
    (current_database())::sql_identifier AS event_object_catalog,
    (n.nspname)::sql_identifier AS event_object_schema,
    (c.relname)::sql_identifier AS event_object_table,
    (a.attname)::sql_identifier AS event_object_column
   FROM pg_namespace n,
    pg_class c,
    pg_trigger t,
    ( SELECT ta0.tgoid,
            (ta0.tgat).x AS tgattnum,
            (ta0.tgat).n AS tgattpos
           FROM ( SELECT pg_trigger.oid AS tgoid,
                    _pg_expandarray(pg_trigger.tgattr) AS tgat
                   FROM pg_trigger) ta0) ta,
    pg_attribute a
  WHERE ((n.oid = c.relnamespace) AND (c.oid = t.tgrelid) AND (t.oid = ta.tgoid) AND ((a.attrelid = t.tgrelid) AND (a.attnum = ta.tgattnum)) AND (NOT t.tgisinternal) AND (NOT pg_is_other_temp_schema(n.oid)) AND (pg_has_role(c.relowner, 'USAGE'::text) OR has_column_privilege(c.oid, a.attnum, 'INSERT, UPDATE, REFERENCES'::text)));
DROP VIEW triggers;
CREATE VIEW triggers (trigger_catalog, trigger_schema, trigger_name, event_manipulation, event_object_catalog, event_object_schema, event_object_table, action_order, action_condition, action_statement, action_orientation, action_timing, action_reference_old_table, action_reference_new_table, action_reference_old_row, action_reference_new_row, created) AS  SELECT (current_database())::sql_identifier AS trigger_catalog,
    (n.nspname)::sql_identifier AS trigger_schema,
    (t.tgname)::sql_identifier AS trigger_name,
    (em.text)::character_data AS event_manipulation,
    (current_database())::sql_identifier AS event_object_catalog,
    (n.nspname)::sql_identifier AS event_object_schema,
    (c.relname)::sql_identifier AS event_object_table,
    (rank() OVER (PARTITION BY n.oid, c.oid, em.num, ((t.tgtype)::integer & 1), ((t.tgtype)::integer & 66) ORDER BY t.tgname))::cardinal_number AS action_order,
    (
        CASE
            WHEN pg_has_role(c.relowner, 'USAGE'::text) THEN (regexp_match(pg_get_triggerdef(t.oid), '.{35,} WHEN \((.+)\) EXECUTE PROCEDURE'::text))[1]
            ELSE NULL::text
        END)::character_data AS action_condition,
    ("substring"(pg_get_triggerdef(t.oid), ("position"("substring"(pg_get_triggerdef(t.oid), 48), 'EXECUTE PROCEDURE'::text) + 47)))::character_data AS action_statement,
    (
        CASE ((t.tgtype)::integer & 1)
            WHEN 1 THEN 'ROW'::text
            ELSE 'STATEMENT'::text
        END)::character_data AS action_orientation,
    (
        CASE ((t.tgtype)::integer & 66)
            WHEN 2 THEN 'BEFORE'::text
            WHEN 64 THEN 'INSTEAD OF'::text
            ELSE 'AFTER'::text
        END)::character_data AS action_timing,
    (t.tgoldtable)::sql_identifier AS action_reference_old_table,
    (t.tgnewtable)::sql_identifier AS action_reference_new_table,
    (NULL::character varying)::sql_identifier AS action_reference_old_row,
    (NULL::character varying)::sql_identifier AS action_reference_new_row,
    (NULL::timestamp with time zone)::time_stamp AS created
   FROM pg_namespace n,
    pg_class c,
    pg_trigger t,
    ( VALUES (4,'INSERT'::text), (8,'DELETE'::text), (16,'UPDATE'::text)) em(num, text)
  WHERE ((n.oid = c.relnamespace) AND (c.oid = t.tgrelid) AND (((t.tgtype)::integer & em.num) <> 0) AND (NOT t.tgisinternal) AND (NOT pg_is_other_temp_schema(n.oid)) AND (pg_has_role(c.relowner, 'USAGE'::text) OR has_table_privilege(c.oid, 'INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(c.oid, 'INSERT, UPDATE, REFERENCES'::text)));
DROP VIEW udt_privileges;
CREATE VIEW udt_privileges (grantor, grantee, udt_catalog, udt_schema, udt_name, privilege_type, is_grantable) AS  SELECT (u_grantor.rolname)::sql_identifier AS grantor,
    (grantee.rolname)::sql_identifier AS grantee,
    (current_database())::sql_identifier AS udt_catalog,
    (n.nspname)::sql_identifier AS udt_schema,
    (t.typname)::sql_identifier AS udt_name,
    ('TYPE USAGE'::character varying)::character_data AS privilege_type,
    (
        CASE
            WHEN (pg_has_role(grantee.oid, t.typowner, 'USAGE'::text) OR t.grantable) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_grantable
   FROM ( SELECT pg_type.oid,
            pg_type.typname,
            pg_type.typnamespace,
            pg_type.typtype,
            pg_type.typowner,
            (aclexplode(COALESCE(pg_type.typacl, acldefault('T'::"char", pg_type.typowner)))).grantor AS grantor,
            (aclexplode(COALESCE(pg_type.typacl, acldefault('T'::"char", pg_type.typowner)))).grantee AS grantee,
            (aclexplode(COALESCE(pg_type.typacl, acldefault('T'::"char", pg_type.typowner)))).privilege_type AS privilege_type,
            (aclexplode(COALESCE(pg_type.typacl, acldefault('T'::"char", pg_type.typowner)))).is_grantable AS is_grantable
           FROM pg_type) t(oid, typname, typnamespace, typtype, typowner, grantor, grantee, prtype, grantable),
    pg_namespace n,
    pg_authid u_grantor,
    ( SELECT pg_authid.oid,
            pg_authid.rolname
           FROM pg_authid
        UNION ALL
         SELECT (0)::oid AS oid,
            'PUBLIC'::name) grantee(oid, rolname)
  WHERE ((t.typnamespace = n.oid) AND (t.typtype = 'c'::"char") AND (t.grantee = grantee.oid) AND (t.grantor = u_grantor.oid) AND (t.prtype = 'USAGE'::text) AND (pg_has_role(u_grantor.oid, 'USAGE'::text) OR pg_has_role(grantee.oid, 'USAGE'::text) OR (grantee.rolname = 'PUBLIC'::name)));
DROP VIEW usage_privileges;
CREATE VIEW usage_privileges (grantor, grantee, object_catalog, object_schema, object_name, object_type, privilege_type, is_grantable) AS  SELECT (u.rolname)::sql_identifier AS grantor,
    ('PUBLIC'::character varying)::sql_identifier AS grantee,
    (current_database())::sql_identifier AS object_catalog,
    (n.nspname)::sql_identifier AS object_schema,
    (c.collname)::sql_identifier AS object_name,
    ('COLLATION'::character varying)::character_data AS object_type,
    ('USAGE'::character varying)::character_data AS privilege_type,
    ('NO'::character varying)::yes_or_no AS is_grantable
   FROM pg_authid u,
    pg_namespace n,
    pg_collation c
  WHERE ((u.oid = c.collowner) AND (c.collnamespace = n.oid) AND (c.collencoding = ANY (ARRAY['-1'::integer, ( SELECT pg_database.encoding
           FROM pg_database
          WHERE (pg_database.datname = current_database()))])))
UNION ALL
 SELECT (u_grantor.rolname)::sql_identifier AS grantor,
    (grantee.rolname)::sql_identifier AS grantee,
    (current_database())::sql_identifier AS object_catalog,
    (n.nspname)::sql_identifier AS object_schema,
    (t.typname)::sql_identifier AS object_name,
    ('DOMAIN'::character varying)::character_data AS object_type,
    ('USAGE'::character varying)::character_data AS privilege_type,
    (
        CASE
            WHEN (pg_has_role(grantee.oid, t.typowner, 'USAGE'::text) OR t.grantable) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_grantable
   FROM ( SELECT pg_type.oid,
            pg_type.typname,
            pg_type.typnamespace,
            pg_type.typtype,
            pg_type.typowner,
            (aclexplode(COALESCE(pg_type.typacl, acldefault('T'::"char", pg_type.typowner)))).grantor AS grantor,
            (aclexplode(COALESCE(pg_type.typacl, acldefault('T'::"char", pg_type.typowner)))).grantee AS grantee,
            (aclexplode(COALESCE(pg_type.typacl, acldefault('T'::"char", pg_type.typowner)))).privilege_type AS privilege_type,
            (aclexplode(COALESCE(pg_type.typacl, acldefault('T'::"char", pg_type.typowner)))).is_grantable AS is_grantable
           FROM pg_type) t(oid, typname, typnamespace, typtype, typowner, grantor, grantee, prtype, grantable),
    pg_namespace n,
    pg_authid u_grantor,
    ( SELECT pg_authid.oid,
            pg_authid.rolname
           FROM pg_authid
        UNION ALL
         SELECT (0)::oid AS oid,
            'PUBLIC'::name) grantee(oid, rolname)
  WHERE ((t.typnamespace = n.oid) AND (t.typtype = 'd'::"char") AND (t.grantee = grantee.oid) AND (t.grantor = u_grantor.oid) AND (t.prtype = 'USAGE'::text) AND (pg_has_role(u_grantor.oid, 'USAGE'::text) OR pg_has_role(grantee.oid, 'USAGE'::text) OR (grantee.rolname = 'PUBLIC'::name)))
UNION ALL
 SELECT (u_grantor.rolname)::sql_identifier AS grantor,
    (grantee.rolname)::sql_identifier AS grantee,
    (current_database())::sql_identifier AS object_catalog,
    (''::character varying)::sql_identifier AS object_schema,
    (fdw.fdwname)::sql_identifier AS object_name,
    ('FOREIGN DATA WRAPPER'::character varying)::character_data AS object_type,
    ('USAGE'::character varying)::character_data AS privilege_type,
    (
        CASE
            WHEN (pg_has_role(grantee.oid, fdw.fdwowner, 'USAGE'::text) OR fdw.grantable) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_grantable
   FROM ( SELECT pg_foreign_data_wrapper.fdwname,
            pg_foreign_data_wrapper.fdwowner,
            (aclexplode(COALESCE(pg_foreign_data_wrapper.fdwacl, acldefault('F'::"char", pg_foreign_data_wrapper.fdwowner)))).grantor AS grantor,
            (aclexplode(COALESCE(pg_foreign_data_wrapper.fdwacl, acldefault('F'::"char", pg_foreign_data_wrapper.fdwowner)))).grantee AS grantee,
            (aclexplode(COALESCE(pg_foreign_data_wrapper.fdwacl, acldefault('F'::"char", pg_foreign_data_wrapper.fdwowner)))).privilege_type AS privilege_type,
            (aclexplode(COALESCE(pg_foreign_data_wrapper.fdwacl, acldefault('F'::"char", pg_foreign_data_wrapper.fdwowner)))).is_grantable AS is_grantable
           FROM pg_foreign_data_wrapper) fdw(fdwname, fdwowner, grantor, grantee, prtype, grantable),
    pg_authid u_grantor,
    ( SELECT pg_authid.oid,
            pg_authid.rolname
           FROM pg_authid
        UNION ALL
         SELECT (0)::oid AS oid,
            'PUBLIC'::name) grantee(oid, rolname)
  WHERE ((u_grantor.oid = fdw.grantor) AND (grantee.oid = fdw.grantee) AND (fdw.prtype = 'USAGE'::text) AND (pg_has_role(u_grantor.oid, 'USAGE'::text) OR pg_has_role(grantee.oid, 'USAGE'::text) OR (grantee.rolname = 'PUBLIC'::name)))
UNION ALL
 SELECT (u_grantor.rolname)::sql_identifier AS grantor,
    (grantee.rolname)::sql_identifier AS grantee,
    (current_database())::sql_identifier AS object_catalog,
    (''::character varying)::sql_identifier AS object_schema,
    (srv.srvname)::sql_identifier AS object_name,
    ('FOREIGN SERVER'::character varying)::character_data AS object_type,
    ('USAGE'::character varying)::character_data AS privilege_type,
    (
        CASE
            WHEN (pg_has_role(grantee.oid, srv.srvowner, 'USAGE'::text) OR srv.grantable) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_grantable
   FROM ( SELECT pg_foreign_server.srvname,
            pg_foreign_server.srvowner,
            (aclexplode(COALESCE(pg_foreign_server.srvacl, acldefault('S'::"char", pg_foreign_server.srvowner)))).grantor AS grantor,
            (aclexplode(COALESCE(pg_foreign_server.srvacl, acldefault('S'::"char", pg_foreign_server.srvowner)))).grantee AS grantee,
            (aclexplode(COALESCE(pg_foreign_server.srvacl, acldefault('S'::"char", pg_foreign_server.srvowner)))).privilege_type AS privilege_type,
            (aclexplode(COALESCE(pg_foreign_server.srvacl, acldefault('S'::"char", pg_foreign_server.srvowner)))).is_grantable AS is_grantable
           FROM pg_foreign_server) srv(srvname, srvowner, grantor, grantee, prtype, grantable),
    pg_authid u_grantor,
    ( SELECT pg_authid.oid,
            pg_authid.rolname
           FROM pg_authid
        UNION ALL
         SELECT (0)::oid AS oid,
            'PUBLIC'::name) grantee(oid, rolname)
  WHERE ((u_grantor.oid = srv.grantor) AND (grantee.oid = srv.grantee) AND (srv.prtype = 'USAGE'::text) AND (pg_has_role(u_grantor.oid, 'USAGE'::text) OR pg_has_role(grantee.oid, 'USAGE'::text) OR (grantee.rolname = 'PUBLIC'::name)))
UNION ALL
 SELECT (u_grantor.rolname)::sql_identifier AS grantor,
    (grantee.rolname)::sql_identifier AS grantee,
    (current_database())::sql_identifier AS object_catalog,
    (n.nspname)::sql_identifier AS object_schema,
    (c.relname)::sql_identifier AS object_name,
    ('SEQUENCE'::character varying)::character_data AS object_type,
    ('USAGE'::character varying)::character_data AS privilege_type,
    (
        CASE
            WHEN (pg_has_role(grantee.oid, c.relowner, 'USAGE'::text) OR c.grantable) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_grantable
   FROM ( SELECT pg_class.oid,
            pg_class.relname,
            pg_class.relnamespace,
            pg_class.relkind,
            pg_class.relowner,
            (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).grantor AS grantor,
            (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).grantee AS grantee,
            (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).privilege_type AS privilege_type,
            (aclexplode(COALESCE(pg_class.relacl, acldefault('r'::"char", pg_class.relowner)))).is_grantable AS is_grantable
           FROM pg_class) c(oid, relname, relnamespace, relkind, relowner, grantor, grantee, prtype, grantable),
    pg_namespace n,
    pg_authid u_grantor,
    ( SELECT pg_authid.oid,
            pg_authid.rolname
           FROM pg_authid
        UNION ALL
         SELECT (0)::oid AS oid,
            'PUBLIC'::name) grantee(oid, rolname)
  WHERE ((c.relnamespace = n.oid) AND (c.relkind = 'S'::"char") AND (c.grantee = grantee.oid) AND (c.grantor = u_grantor.oid) AND (c.prtype = 'USAGE'::text) AND (pg_has_role(u_grantor.oid, 'USAGE'::text) OR pg_has_role(grantee.oid, 'USAGE'::text) OR (grantee.rolname = 'PUBLIC'::name)));
DROP VIEW user_defined_types;
CREATE VIEW user_defined_types (user_defined_type_catalog, user_defined_type_schema, user_defined_type_name, user_defined_type_category, is_instantiable, is_final, ordering_form, ordering_category, ordering_routine_catalog, ordering_routine_schema, ordering_routine_name, reference_type, data_type, character_maximum_length, character_octet_length, character_set_catalog, character_set_schema, character_set_name, collation_catalog, collation_schema, collation_name, numeric_precision, numeric_precision_radix, numeric_scale, datetime_precision, interval_type, interval_precision, source_dtd_identifier, ref_dtd_identifier) AS  SELECT (current_database())::sql_identifier AS user_defined_type_catalog,
    (n.nspname)::sql_identifier AS user_defined_type_schema,
    (c.relname)::sql_identifier AS user_defined_type_name,
    ('STRUCTURED'::character varying)::character_data AS user_defined_type_category,
    ('YES'::character varying)::yes_or_no AS is_instantiable,
    (NULL::character varying)::yes_or_no AS is_final,
    (NULL::character varying)::character_data AS ordering_form,
    (NULL::character varying)::character_data AS ordering_category,
    (NULL::character varying)::sql_identifier AS ordering_routine_catalog,
    (NULL::character varying)::sql_identifier AS ordering_routine_schema,
    (NULL::character varying)::sql_identifier AS ordering_routine_name,
    (NULL::character varying)::character_data AS reference_type,
    (NULL::character varying)::character_data AS data_type,
    (NULL::integer)::cardinal_number AS character_maximum_length,
    (NULL::integer)::cardinal_number AS character_octet_length,
    (NULL::character varying)::sql_identifier AS character_set_catalog,
    (NULL::character varying)::sql_identifier AS character_set_schema,
    (NULL::character varying)::sql_identifier AS character_set_name,
    (NULL::character varying)::sql_identifier AS collation_catalog,
    (NULL::character varying)::sql_identifier AS collation_schema,
    (NULL::character varying)::sql_identifier AS collation_name,
    (NULL::integer)::cardinal_number AS numeric_precision,
    (NULL::integer)::cardinal_number AS numeric_precision_radix,
    (NULL::integer)::cardinal_number AS numeric_scale,
    (NULL::integer)::cardinal_number AS datetime_precision,
    (NULL::character varying)::character_data AS interval_type,
    (NULL::integer)::cardinal_number AS interval_precision,
    (NULL::character varying)::sql_identifier AS source_dtd_identifier,
    (NULL::character varying)::sql_identifier AS ref_dtd_identifier
   FROM pg_namespace n,
    pg_class c,
    pg_type t
  WHERE ((n.oid = c.relnamespace) AND (t.typrelid = c.oid) AND (c.relkind = 'c'::"char") AND (pg_has_role(t.typowner, 'USAGE'::text) OR has_type_privilege(t.oid, 'USAGE'::text)));
DROP VIEW user_mapping_options;
CREATE VIEW user_mapping_options (authorization_identifier, foreign_server_catalog, foreign_server_name, option_name, option_value) AS  SELECT um.authorization_identifier,
    um.foreign_server_catalog,
    um.foreign_server_name,
    (opts.option_name)::sql_identifier AS option_name,
    (
        CASE
            WHEN (((um.umuser <> (0)::oid) AND ((um.authorization_identifier)::name = CURRENT_USER)) OR ((um.umuser = (0)::oid) AND pg_has_role((um.srvowner)::name, 'USAGE'::text)) OR ( SELECT pg_authid.rolsuper
               FROM pg_authid
              WHERE (pg_authid.rolname = CURRENT_USER))) THEN opts.option_value
            ELSE NULL::text
        END)::character_data AS option_value
   FROM _pg_user_mappings um,
    LATERAL pg_options_to_table(um.umoptions) opts(option_name, option_value);
DROP VIEW user_mappings;
CREATE VIEW user_mappings (authorization_identifier, foreign_server_catalog, foreign_server_name) AS  SELECT _pg_user_mappings.authorization_identifier,
    _pg_user_mappings.foreign_server_catalog,
    _pg_user_mappings.foreign_server_name
   FROM _pg_user_mappings;
DROP VIEW view_column_usage;
CREATE VIEW view_column_usage (view_catalog, view_schema, view_name, table_catalog, table_schema, table_name, column_name) AS  SELECT DISTINCT (current_database())::sql_identifier AS view_catalog,
    (nv.nspname)::sql_identifier AS view_schema,
    (v.relname)::sql_identifier AS view_name,
    (current_database())::sql_identifier AS table_catalog,
    (nt.nspname)::sql_identifier AS table_schema,
    (t.relname)::sql_identifier AS table_name,
    (a.attname)::sql_identifier AS column_name
   FROM pg_namespace nv,
    pg_class v,
    pg_depend dv,
    pg_depend dt,
    pg_class t,
    pg_namespace nt,
    pg_attribute a
  WHERE ((nv.oid = v.relnamespace) AND (v.relkind = 'v'::"char") AND (v.oid = dv.refobjid) AND (dv.refclassid = ('pg_class'::regclass)::oid) AND (dv.classid = ('pg_rewrite'::regclass)::oid) AND (dv.deptype = 'i'::"char") AND (dv.objid = dt.objid) AND (dv.refobjid <> dt.refobjid) AND (dt.classid = ('pg_rewrite'::regclass)::oid) AND (dt.refclassid = ('pg_class'::regclass)::oid) AND (dt.refobjid = t.oid) AND (t.relnamespace = nt.oid) AND (t.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'f'::"char", 'p'::"char"])) AND (t.oid = a.attrelid) AND (dt.refobjsubid = a.attnum) AND pg_has_role(t.relowner, 'USAGE'::text));
DROP VIEW view_routine_usage;
CREATE VIEW view_routine_usage (table_catalog, table_schema, table_name, specific_catalog, specific_schema, specific_name) AS  SELECT DISTINCT (current_database())::sql_identifier AS table_catalog,
    (nv.nspname)::sql_identifier AS table_schema,
    (v.relname)::sql_identifier AS table_name,
    (current_database())::sql_identifier AS specific_catalog,
    (np.nspname)::sql_identifier AS specific_schema,
    ((((p.proname)::text || '_'::text) || (p.oid)::text))::sql_identifier AS specific_name
   FROM pg_namespace nv,
    pg_class v,
    pg_depend dv,
    pg_depend dp,
    pg_proc p,
    pg_namespace np
  WHERE ((nv.oid = v.relnamespace) AND (v.relkind = 'v'::"char") AND (v.oid = dv.refobjid) AND (dv.refclassid = ('pg_class'::regclass)::oid) AND (dv.classid = ('pg_rewrite'::regclass)::oid) AND (dv.deptype = 'i'::"char") AND (dv.objid = dp.objid) AND (dp.classid = ('pg_rewrite'::regclass)::oid) AND (dp.refclassid = ('pg_proc'::regclass)::oid) AND (dp.refobjid = p.oid) AND (p.pronamespace = np.oid) AND pg_has_role(p.proowner, 'USAGE'::text));
DROP VIEW view_table_usage;
CREATE VIEW view_table_usage (view_catalog, view_schema, view_name, table_catalog, table_schema, table_name) AS  SELECT DISTINCT (current_database())::sql_identifier AS view_catalog,
    (nv.nspname)::sql_identifier AS view_schema,
    (v.relname)::sql_identifier AS view_name,
    (current_database())::sql_identifier AS table_catalog,
    (nt.nspname)::sql_identifier AS table_schema,
    (t.relname)::sql_identifier AS table_name
   FROM pg_namespace nv,
    pg_class v,
    pg_depend dv,
    pg_depend dt,
    pg_class t,
    pg_namespace nt
  WHERE ((nv.oid = v.relnamespace) AND (v.relkind = 'v'::"char") AND (v.oid = dv.refobjid) AND (dv.refclassid = ('pg_class'::regclass)::oid) AND (dv.classid = ('pg_rewrite'::regclass)::oid) AND (dv.deptype = 'i'::"char") AND (dv.objid = dt.objid) AND (dv.refobjid <> dt.refobjid) AND (dt.classid = ('pg_rewrite'::regclass)::oid) AND (dt.refclassid = ('pg_class'::regclass)::oid) AND (dt.refobjid = t.oid) AND (t.relnamespace = nt.oid) AND (t.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'f'::"char", 'p'::"char"])) AND pg_has_role(t.relowner, 'USAGE'::text));
DROP VIEW views;
CREATE VIEW views (table_catalog, table_schema, table_name, view_definition, check_option, is_updatable, is_insertable_into, is_trigger_updatable, is_trigger_deletable, is_trigger_insertable_into) AS  SELECT (current_database())::sql_identifier AS table_catalog,
    (nc.nspname)::sql_identifier AS table_schema,
    (c.relname)::sql_identifier AS table_name,
    (
        CASE
            WHEN pg_has_role(c.relowner, 'USAGE'::text) THEN pg_get_viewdef(c.oid)
            ELSE NULL::text
        END)::character_data AS view_definition,
    (
        CASE
            WHEN ('check_option=cascaded'::text = ANY (c.reloptions)) THEN 'CASCADED'::text
            WHEN ('check_option=local'::text = ANY (c.reloptions)) THEN 'LOCAL'::text
            ELSE 'NONE'::text
        END)::character_data AS check_option,
    (
        CASE
            WHEN ((pg_relation_is_updatable((c.oid)::regclass, false) & 20) = 20) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_updatable,
    (
        CASE
            WHEN ((pg_relation_is_updatable((c.oid)::regclass, false) & 8) = 8) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_insertable_into,
    (
        CASE
            WHEN (EXISTS ( SELECT 1
               FROM pg_trigger
              WHERE ((pg_trigger.tgrelid = c.oid) AND (((pg_trigger.tgtype)::integer & 81) = 81)))) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_trigger_updatable,
    (
        CASE
            WHEN (EXISTS ( SELECT 1
               FROM pg_trigger
              WHERE ((pg_trigger.tgrelid = c.oid) AND (((pg_trigger.tgtype)::integer & 73) = 73)))) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_trigger_deletable,
    (
        CASE
            WHEN (EXISTS ( SELECT 1
               FROM pg_trigger
              WHERE ((pg_trigger.tgrelid = c.oid) AND (((pg_trigger.tgtype)::integer & 69) = 69)))) THEN 'YES'::text
            ELSE 'NO'::text
        END)::yes_or_no AS is_trigger_insertable_into
   FROM pg_namespace nc,
    pg_class c
  WHERE ((c.relnamespace = nc.oid) AND (c.relkind = 'v'::"char") AND (NOT pg_is_other_temp_schema(nc.oid)) AND (pg_has_role(c.relowner, 'USAGE'::text) OR has_table_privilege(c.oid, 'SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(c.oid, 'SELECT, INSERT, UPDATE, REFERENCES'::text)));
DROP FUNCTION _pg_char_max_length (oid, integer);
--/
CREATE FUNCTION _pg_char_max_length (typid oid, typmod integer)  RETURNS integer
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
SELECT
  CASE WHEN $2 = -1 /* default typmod */
       THEN null
       WHEN $1 IN (1042, 1043) /* char, varchar */
       THEN $2 - 4
       WHEN $1 IN (1560, 1562) /* bit, varbit */
       THEN $2
       ELSE null
  END
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_char_octet_length (oid, integer);
--/
CREATE FUNCTION _pg_char_octet_length (typid oid, typmod integer)  RETURNS integer
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
SELECT
  CASE WHEN $1 IN (25, 1042, 1043) /* text, char, varchar */
       THEN CASE WHEN $2 = -1 /* default typmod */
                 THEN CAST(2^30 AS integer)
                 ELSE information_schema._pg_char_max_length($1, $2) *
                      pg_catalog.pg_encoding_max_length((SELECT encoding FROM pg_catalog.pg_database WHERE datname = pg_catalog.current_database()))
            END
       ELSE null
  END
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_datetime_precision (oid, integer);
--/
CREATE FUNCTION _pg_datetime_precision (typid oid, typmod integer)  RETURNS integer
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
SELECT
  CASE WHEN $1 IN (1082) /* date */
           THEN 0
       WHEN $1 IN (1083, 1114, 1184, 1266) /* time, timestamp, same + tz */
           THEN CASE WHEN $2 < 0 THEN 6 ELSE $2 END
       WHEN $1 IN (1186) /* interval */
           THEN CASE WHEN $2 < 0 OR $2 & 65535 = 65535 THEN 6 ELSE $2 & 65535 END
       ELSE null
  END
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_expandarray (anyarray);
--/
CREATE FUNCTION _pg_expandarray (anyarray, OUT x anyelement, OUT n integer)  RETURNS SETOF record
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
select $1[s], s - pg_catalog.array_lower($1,1) + 1
        from pg_catalog.generate_series(pg_catalog.array_lower($1,1),
                                        pg_catalog.array_upper($1,1),
                                        1) as g(s)
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_index_position (oid, smallint);
--/
CREATE FUNCTION _pg_index_position (oid, smallint)  RETURNS integer
  STABLE
  RETURNS NULL ON NULL INPUT
AS $body$
SELECT (ss.a).n FROM
  (SELECT information_schema._pg_expandarray(indkey) AS a
   FROM pg_catalog.pg_index WHERE indexrelid = $1) ss
  WHERE (ss.a).x = $2;
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_interval_type (oid, integer);
--/
CREATE FUNCTION _pg_interval_type (typid oid, mod integer)  RETURNS text
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
SELECT
  CASE WHEN $1 IN (1186) /* interval */
           THEN upper(substring(format_type($1, $2) from 'interval[()0-9]* #"%#"' for '#'))
       ELSE null
  END
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_keysequal (smallint[], smallint[]);
--/
CREATE FUNCTION _pg_keysequal (smallint[], smallint[])  RETURNS boolean
  IMMUTABLE
AS $body$
select $1 operator(pg_catalog.<@) $2 and $2 operator(pg_catalog.<@) $1
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_numeric_precision (oid, integer);
--/
CREATE FUNCTION _pg_numeric_precision (typid oid, typmod integer)  RETURNS integer
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
SELECT
  CASE $1
         WHEN 21 /*int2*/ THEN 16
         WHEN 23 /*int4*/ THEN 32
         WHEN 20 /*int8*/ THEN 64
         WHEN 1700 /*numeric*/ THEN
              CASE WHEN $2 = -1
                   THEN null
                   ELSE (($2 - 4) >> 16) & 65535
                   END
         WHEN 700 /*float4*/ THEN 24 /*FLT_MANT_DIG*/
         WHEN 701 /*float8*/ THEN 53 /*DBL_MANT_DIG*/
         ELSE null
  END
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_numeric_precision_radix (oid, integer);
--/
CREATE FUNCTION _pg_numeric_precision_radix (typid oid, typmod integer)  RETURNS integer
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
SELECT
  CASE WHEN $1 IN (21, 23, 20, 700, 701) THEN 2
       WHEN $1 IN (1700) THEN 10
       ELSE null
  END
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_numeric_scale (oid, integer);
--/
CREATE FUNCTION _pg_numeric_scale (typid oid, typmod integer)  RETURNS integer
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
SELECT
  CASE WHEN $1 IN (21, 23, 20) THEN 0
       WHEN $1 IN (1700) THEN
            CASE WHEN $2 = -1
                 THEN null
                 ELSE ($2 - 4) & 65535
                 END
       ELSE null
  END
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_truetypid (pg_attribute, pg_type);
--/
CREATE FUNCTION _pg_truetypid (pg_attribute, pg_type)  RETURNS oid
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
SELECT CASE WHEN $2.typtype = 'd' THEN $2.typbasetype ELSE $1.atttypid END
$body$ LANGUAGE sql
/
DROP FUNCTION _pg_truetypmod (pg_attribute, pg_type);
--/
CREATE FUNCTION _pg_truetypmod (pg_attribute, pg_type)  RETURNS integer
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
SELECT CASE WHEN $2.typtype = 'd' THEN $2.typtypmod ELSE $1.atttypmod END
$body$ LANGUAGE sql
/
