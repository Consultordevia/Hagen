#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50090 "Datos Mailchip"
{
    PageType = List;
    SourceTable = "Datos mailchip";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Email Address";Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("First Name";Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name";Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(Nombre;Rec.Nombre)
                {
                    ApplicationArea = Basic;
                }
                field(Navision;Rec.Navision)
                {
                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    begin

                        Customer.Reset;
                        Customer.SetRange(Customer."No.",Rec.Navision);
                        if Customer.FindFirst then begin
                            Clear(CustomerCard);
                            CustomerCard.SetTableview(Customer);
                            CustomerCard.RunModal;
                        end;
                    end;
                }
                field(Tienda;Rec.Tienda)
                {
                    ApplicationArea = Basic;
                }
                field("Grupo Des Web";Rec."Grupo Des Web")
                {
                    ApplicationArea = Basic;
                }
                field(Pais;Rec.Pais)
                {
                    ApplicationArea = Basic;
                }
                field(Provincia;Rec.Provincia)
                {
                    ApplicationArea = Basic;
                }
                field(ACUARIOFIL;Rec.ACUARIOFIL)
                {
                    ApplicationArea = Basic;
                }
                field(ESTANQUES;Rec.ESTANQUES)
                {
                    ApplicationArea = Basic;
                }
                field(GATOS;Rec.GATOS)
                {
                    ApplicationArea = Basic;
                }
                field(PAJAROS;Rec.PAJAROS)
                {
                    ApplicationArea = Basic;
                }
                field("PEQ ANIMAL";Rec."PEQ ANIMAL")
                {
                    ApplicationArea = Basic;
                }
                field(PERROS;Rec.PERROS)
                {
                    ApplicationArea = Basic;
                }
                field(REPTILES;Rec.REPTILES)
                {
                    ApplicationArea = Basic;
                }
                field("Alta Web";Rec."Alta Web")
                {
                    ApplicationArea = Basic;
                }
                field("Pedido web";Rec."Pedido web")
                {
                    ApplicationArea = Basic;
                }
                field("Pedido 2 meses";Rec."Pedido 2 meses")
                {
                    ApplicationArea = Basic;
                }
                field(Comercial;Rec.Comercial)
                {
                    ApplicationArea = Basic;
                }
                field(ABC;Rec.ABC)
                {
                    ApplicationArea = Basic;
                }
                field("Estatus cliente";Rec."Estatus cliente")
                {
                    ApplicationArea = Basic;
                }
                field("Tipo cliente";Rec."Tipo cliente")
                {
                    ApplicationArea = Basic;
                }
                field("Total venta";Rec."Total venta")
                {
                    ApplicationArea = Basic;
                }
                field(Comunidad;Rec.Comunidad)
                {
                    ApplicationArea = Basic;
                }
                field("Cod Clasificacion Web";Rec."Cod Clasificacion Web")
                {
                    ApplicationArea = Basic;
                }
                field(Promocion;Rec.Promocion)
                {
                    ApplicationArea = Basic;
                }
                field(MEMBER_RATING;Rec.MEMBER_RATING)
                {
                    ApplicationArea = Basic;
                }
                field(OPTIN_TIME;Rec.OPTIN_TIME)
                {
                    ApplicationArea = Basic;
                }
                field(OPTIN_IP;Rec.OPTIN_IP)
                {
                    ApplicationArea = Basic;
                }
                field(CONFIRM_TIME;Rec.CONFIRM_TIME)
                {
                    ApplicationArea = Basic;
                }
                field(CONFIRM_IP;Rec.CONFIRM_IP)
                {
                    ApplicationArea = Basic;
                }
                field(LATITUDE;Rec.LATITUDE)
                {
                    ApplicationArea = Basic;
                }
                field(LONGITUDE;Rec.LONGITUDE)
                {
                    ApplicationArea = Basic;
                }
                field(GMTOFF;Rec.GMTOFF)
                {
                    ApplicationArea = Basic;
                }
                field(DSTOFF;Rec.DSTOFF)
                {
                    ApplicationArea = Basic;
                }
                field(TimeZone;Rec.TimeZone)
                {
                    ApplicationArea = Basic;
                }
                field(CC;Rec.CC)
                {
                    ApplicationArea = Basic;
                }
                field(REGION;Rec.REGION)
                {
                    ApplicationArea = Basic;
                }
                field(LAST_CHANGED;Rec.LAST_CHANGED)
                {
                    ApplicationArea = Basic;
                }
                field(LEID;Rec.LEID)
                {
                    ApplicationArea = Basic;
                }
                field(EUID;Rec.EUID)
                {
                    ApplicationArea = Basic;
                }
                field(NOTES;Rec.NOTES)
                {
                    ApplicationArea = Basic;
                }
                field(TAGS;Rec.TAGS)
                {
                    ApplicationArea = Basic;
                }
                field("Diferente email";Rec."Diferente email")
                {
                    ApplicationArea = Basic;
                }
                field(Diferencias;Rec.Diferencias)
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Email Address";Rec."Nav-Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Tienda";Rec."Nav-Tienda")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Grupo Des Web";Rec."Nav-Grupo Des Web")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Pais";Rec."Nav-Pais")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Provincia";Rec."Nav-Provincia")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-ACUARIOFIL";Rec."Nav-ACUARIOFIL")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-ESTANQUES";Rec."Nav-ESTANQUES")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-GATOS";Rec."Nav-GATOS")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-PAJAROS";Rec."Nav-PAJAROS")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-PEQ ANIMAL";Rec."Nav-PEQ ANIMAL")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-PERROS";Rec."Nav-PERROS")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-REPTILES";Rec."Nav-REPTILES")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Alta Web";Rec."Nav-Alta Web")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Pedido web";Rec."Nav-Pedido web")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Pedido 2 meses";Rec."Nav-Pedido 2 meses")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Comercial";Rec."Nav-Comercial")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-ABC";Rec."Nav-ABC")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Estatus cliente";Rec."Nav-Estatus cliente")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Tipo cliente";Rec."Nav-Tipo cliente")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Comunidad";Rec."Nav-Comunidad")
                {
                    ApplicationArea = Basic;
                }
                field("Nav-Cod Clasificacion Web";Rec."Nav-Cod Clasificacion Web")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Valida datos")
            {
                ApplicationArea = Basic;
                Caption = 'Valida datos';
                Ellipsis = true;
                Image = Add;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    V.Open('#1#######################');

                    Datosmailchip.Reset;
                    if Datosmailchip.FindFirst then repeat
                        if Customer.Get(Datosmailchip.Navision) then begin
                            V.Update(1,Customer."No.");
                            Datosmailchip."Diferente email":=false;
                            Datosmailchip.Diferencias:='';
                            Datosmailchip."Nav-ACUARIOFIL":='';
                            Datosmailchip."Nav-ESTANQUES":='';
                            Datosmailchip."Nav-GATOS":='';
                            Datosmailchip."Nav-PAJAROS":='';
                            Datosmailchip."Nav-PEQ ANIMAL":='';
                            Datosmailchip."Nav-PERROS":='';
                            Datosmailchip."Nav-REPTILES":='';
                            if Datosmailchip."Email Address"<>Customer."E-Mail" then begin
                                Datosmailchip."Diferente email":=true;
                                Datosmailchip."Nav-Email Address":=Customer."E-Mail";
                            end;
                            if Customer."Name 2"<>Datosmailchip.Tienda then begin
                                Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'Tienda-';
                                Datosmailchip."Nav-Tienda":=Customer."Name 2";
                            end;
                            if Customer."Customer Disc. Group"<>Datosmailchip."Grupo Des Web" then begin
                                Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'Gr.dto cli.-';
                                Datosmailchip."Nav-Grupo Des Web":=Customer."Customer Disc. Group";
                            end;
                            if Customer.County<>Datosmailchip.Provincia then begin
                                Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'Provincia-';
                                Datosmailchip."Nav-Provincia":=Customer.County;
                            end;
                            if SalespersonPurchaser.Get(Customer."Salesperson Code") then begin
                                if SalespersonPurchaser.Name<>Datosmailchip.Comercial then begin
                                    Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'Comercial-';
                                    Datosmailchip."Nav-Comercial":=SalespersonPurchaser.Name;
                                end;
                            end;
                            /////Customer.CALCFIELDS("Vta. Acuariofilia","Vta.Gatos","Vta.Pajaros","Vta.Perro","Vta.Reptiles","Vta.Roedores");
                            if (Customer."Vta. Acuariofilia"<>0) and (CopyStr(Datosmailchip.ACUARIOFIL,1,1)='N') then begin
                                  Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'ACUARIOFIL-';
                                  Datosmailchip."Nav-ACUARIOFIL":='S';
                            end;
                            if (Customer."Vta.Gatos"<>0) and (CopyStr(Datosmailchip.GATOS,1,1)='N') then begin
                                  Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'GATOS-';
                                  Datosmailchip."Nav-GATOS":='S';
                            end;
                            if (Customer."Vta.Pajaros"<>0) and (CopyStr(Datosmailchip.PAJAROS,1,1)='N') then begin
                                  Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'PAJAROS-';
                                  Datosmailchip."Nav-PAJAROS":='S';
                            end;
                            if (Customer."Vta.Perro"<>0) and (CopyStr(Datosmailchip.PERROS,1,1)='N') then begin
                                  Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'PERROS-';
                                  Datosmailchip."Nav-PERROS":='S';
                            end;
                            if (Customer."Vta.Reptiles"<>0) and (CopyStr(Datosmailchip.REPTILES,1,1)='N') then begin
                                  Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'REPTILES-';
                                  Datosmailchip."Nav-REPTILES":='S';
                            end;
                            if (Customer."Vta. Acuariofilia"=0) and (CopyStr(Datosmailchip.ACUARIOFIL,1,1)='S') then begin
                                  Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'NO ACUARIOFIL-';
                                  Datosmailchip."Nav-ACUARIOFIL":='N';
                            end;
                            if (Customer."Vta.Gatos"=0) and (CopyStr(Datosmailchip.GATOS,1,1)='S') then begin
                                  Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'NO GATOS-';
                                  Datosmailchip."Nav-GATOS":='N';
                            end;
                            if (Customer."Vta.Pajaros"=0) and (CopyStr(Datosmailchip.PAJAROS,1,1)='S') then begin
                                  Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'NO PAJAROS-';
                                  Datosmailchip."Nav-PAJAROS":='N';
                            end;
                            if (Customer."Vta.Perro"=0) and (CopyStr(Datosmailchip.PERROS,1,1)='S') then begin
                                  Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'NO PERROS-';
                                  Datosmailchip."Nav-PERROS":='N';
                            end;
                            if (Customer."Vta.Reptiles"=0) and (CopyStr(Datosmailchip.REPTILES,1,1)='S') then begin
                                  Datosmailchip.Diferencias:=Datosmailchip.Diferencias+'NO REPTILES-';
                                  Datosmailchip."Nav-REPTILES":='N';
                            end;
                            Datosmailchip.Modify;
                        end;
                    until Datosmailchip.Next=0;


                        Datosmailchip.Reset;
                        if Datosmailchip.FindFirst then repeat
                            if CopyStr(Datosmailchip.Diferencias,1,5)='NUEVO' then begin
                                Datosmailchip.Delete;
                            end;
                        until Datosmailchip.Next=0;



                    CustomerNew.Reset;
                    if CustomerNew.FindFirst then repeat
                      if CustomerNew."No email chimp"=false then begin
                      V.Update(1,CustomerNew."No.");
                      if (CustomerNew."Estatus del cliente"=CustomerNew."estatus del cliente"::Activo) or
                         (CustomerNew."Estatus del cliente"=CustomerNew."estatus del cliente"::"Posible cliente") or
                         (CustomerNew."Estatus del cliente"=CustomerNew."estatus del cliente"::"Posible cliente WEB") then begin
                        Datosmailchip.Reset;
                        Datosmailchip.SetRange(Datosmailchip.Navision,CustomerNew."No.");
                        if not Datosmailchip.FindFirst then begin
                            DatosmailchipNew.Init;
                            DatosmailchipNew.Navision:=CustomerNew."No.";
                            DatosmailchipNew."Email Address":=CustomerNew."E-Mail";
                            DatosmailchipNew.Nombre:=CustomerNew.Name;
                            DatosmailchipNew.Tienda:=CustomerNew."Search Name";
                            DatosmailchipNew."Grupo Des Web":=CustomerNew."Invoice Disc. Code";
                            DatosmailchipNew.Pais:=CustomerNew."Country/Region Code";
                            DatosmailchipNew.Provincia:=CustomerNew.County;
                            DatosmailchipNew.ACUARIOFIL:='N';
                            DatosmailchipNew.ESTANQUES:='N';
                            DatosmailchipNew.GATOS:='N';
                            DatosmailchipNew.PAJAROS:='N';
                            DatosmailchipNew."PEQ ANIMAL":='N';
                            DatosmailchipNew.PERROS:='N';
                            DatosmailchipNew.REPTILES:='N';
                            if CustomerNew."Vta. Acuariofilia"<>0 then begin DatosmailchipNew.ACUARIOFIL:='S';end;
                            if CustomerNew."Vta.Gatos"<>0 then begin DatosmailchipNew.GATOS:='S';end;
                            if CustomerNew."Vta.Pajaros"<>0 then begin DatosmailchipNew.PAJAROS:='S';end;
                            if CustomerNew."Vta.Roedores"<>0 then begin DatosmailchipNew."PEQ ANIMAL":='S';end;
                            if CustomerNew."Vta.Perro"<>0 then begin DatosmailchipNew.PERROS:='S';end;
                            if CustomerNew."Vta.Reptiles"<>0 then begin DatosmailchipNew.REPTILES:='S';end;
                            if SalespersonPurchaser.Get(CustomerNew."Salesperson Code") then begin
                                DatosmailchipNew.Comercial:=SalespersonPurchaser.Name;
                            end;
                            DatosmailchipNew."Diferente email":=true;
                            DatosmailchipNew.Diferencias:='NUEVO';
                            DatosmailchipNew.Insert;
                        end;
                        end;
                        end;
                    until CustomerNew.Next=0;


                    V.Close;
                    Message('Hecho.');
                end;
            }
        }
    }

    var
        Customer: Record Customer;
        Datosmailchip: Record "Datos mailchip";
        CustomerCard: Page "Customer Card";
        "Area": Record "Area";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        V: Dialog;
        CustomerNew: Record Customer;
        DatosmailchipNew: Record "Datos mailchip";
}

