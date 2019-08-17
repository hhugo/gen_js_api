let mapper = Gen_js_api_ppx.mapper

let copy_attribute (a : Parsetree.attribute) : Ppxlib.Ast.attribute =
  (a.attr_name, PStr [])

let () =
  Ppxlib.Driver.enable_checks ();
  Gen_js_api_ppx.check_attribute := false;
  (Gen_js_api_ppx.mark_as_handled_manually :=
     fun attribute ->
       let attribute = copy_attribute attribute in
       Ppxlib.Attribute.mark_as_handled_manually attribute);
  Ppxlib.Driver.register_transformation_using_ocaml_current_ast "gen_js_api"
    ~impl:(fun str -> mapper.structure mapper str)
    ~intf:(fun sig_ -> mapper.signature mapper sig_)
