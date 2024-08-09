#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50048 "Amazon prevision"
{

    fields
    {
        field(1;conta;Integer)
        {
            AutoIncrement = true;
        }
        field(2;d1;Code[30])
        {

            trigger OnValidate()
            begin

                Item.Reset;
                Item.SetRange("Ref. AMAZON",d1);
                if Item.FindFirst then begin
                    Producto:=Item."No.";
                end;
            end;
        }
        field(3;d2;Code[70])
        {
        }
        field(4;d3;Code[20])
        {
        }
        field(5;d4;Code[20])
        {
        }
        field(6;d5;Code[20])
        {
        }
        field(7;d6;Code[20])
        {
        }
        field(8;d7;Code[20])
        {
        }
        field(9;d8;Code[20])
        {
        }
        field(10;d9;Code[20])
        {
        }
        field(11;d10;Code[20])
        {
        }
        field(12;d11;Code[20])
        {
        }
        field(13;d12;Code[20])
        {
        }
        field(14;d13;Code[20])
        {
        }
        field(15;d14;Code[20])
        {
        }
        field(16;d15;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d15<>'' then begin
                    Evaluate(c1,d15);
                end;
                end;
            end;
        }
        field(17;d16;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d16<>'' then begin
                    Evaluate(c2,d16);
                end;
                end;
            end;
        }
        field(18;d17;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d17<>'' then begin
                    Evaluate(c3,d17);
                end;
                end;
            end;
        }
        field(19;d18;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d18<>'' then begin
                    Evaluate(c4,d18);
                end;
                end;
            end;
        }
        field(20;d19;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d19<>'' then begin
                    Evaluate(c5,d19);
                end;
                end;
            end;
        }
        field(21;d20;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d20<>'' then begin
                    Evaluate(c6,d20);
                end;
                end;
            end;
        }
        field(22;d21;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d21<>'' then begin
                    Evaluate(c7,d21);
                end;
                end;
            end;
        }
        field(23;d22;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d22<>'' then begin
                    Evaluate(c8,d22);
                end;
                end;
            end;
        }
        field(24;d23;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d23<>'' then begin
                    Evaluate(c9,d23);
                end;
                end;
            end;
        }
        field(25;d24;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d24<>'' then begin
                    Evaluate(c10,d24);
                end;

                end;
            end;
        }
        field(26;d25;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d25<>'' then begin
                    Evaluate(c11,d25);
                end;
                end;
            end;
        }
        field(27;d26;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d26<>'' then begin
                    Evaluate(c12,d26);
                end;
                end;
            end;
        }
        field(28;d27;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d27<>'' then begin
                    Evaluate(c13,d27);
                end;
                end;
            end;
        }
        field(29;d28;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d28<>'' then begin
                    Evaluate(c14,d28);
                end;
                end;
            end;
        }
        field(30;d29;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d29<>'' then begin
                    Evaluate(c15,d29);
                end;
                end;
            end;
        }
        field(31;d30;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d30<>'' then begin
                    Evaluate(c16,d30);
                end;
                end;
            end;
        }
        field(32;d31;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d31<>'' then begin
                    Evaluate(c17,d31);
                end;
                end;
            end;
        }
        field(33;d32;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d32<>'' then begin
                    Evaluate(c18,d32);
                end;
                end;
            end;
        }
        field(34;d33;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d33<>'' then begin
                    Evaluate(c19,d33);
                end;
                end;
            end;
        }
        field(35;d34;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d34<>'' then begin
                    Evaluate(c20,d34);
                end;
                end;
            end;
        }
        field(36;d35;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d35<>'' then begin
                    Evaluate(c21,d35);
                end;
                end;
            end;
        }
        field(37;d36;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d36<>'' then begin
                    Evaluate(c22,d36);
                end;
                end;
            end;
        }
        field(38;d37;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d37<>'' then begin
                    Evaluate(c23,d37);
                end;
                end;
            end;
        }
        field(39;d38;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d38<>'' then begin
                    Evaluate(c24,d38);
                end;
                end;
            end;
        }
        field(40;d39;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d39<>'' then begin
                    Evaluate(c25,d39);
                end;
                end;
            end;
        }
        field(41;d40;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d40<>'' then begin
                    Evaluate(c26,d40);
                end;
                end;
            end;
        }
        field(42;d41;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d41<>'' then begin
                    Evaluate(c27,d41);
                end;
                end;
            end;
        }
        field(43;d42;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d42<>'' then begin
                    Evaluate(c28,d42);
                end;
                end;
            end;
        }
        field(44;d43;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d43<>'' then begin
                    Evaluate(c29,d43);
                end;
                end;
            end;
        }
        field(45;d44;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d44<>'' then begin
                    Evaluate(c30,d44);
                end;
                end;
            end;
        }
        field(46;d45;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d45<>'' then begin
                    Evaluate(c31,d45);
                end;
                end;
            end;
        }
        field(47;d46;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d46<>'' then begin
                    Evaluate(c32,d46);
                end;
                end;
            end;
        }
        field(48;d47;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d47<>'' then begin
                    Evaluate(c33,d47);
                end;
                end;
            end;
        }
        field(49;d48;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d48<>'' then begin
                    Evaluate(c34,d48);
                end;
                end;
            end;
        }
        field(50;d49;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d49<>'' then begin
                    Evaluate(c35,d49);
                end;
                end;
            end;
        }
        field(51;d50;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d50<>'' then begin
                    Evaluate(c36,d50);
                end;
                end;
            end;
        }
        field(52;d51;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d51<>'' then begin
                    Evaluate(c37,d51);
                end;
                end;
            end;
        }
        field(53;d52;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d52<>'' then begin
                    Evaluate(c38,d52);
                end;
                end;
            end;
        }
        field(54;d53;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d53<>'' then begin
                    Evaluate(c39,d53);
                end;
                end;
            end;
        }
        field(55;d54;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d54<>'' then begin
                    Evaluate(c40,d54);
                end;
                end;
            end;
        }
        field(56;d55;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d55<>'' then begin
                    Evaluate(c41,d55);
                end;
                end;
            end;
        }
        field(57;d56;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d56<>'' then begin
                    Evaluate(c42,d56);
                end;
                end;
            end;
        }
        field(58;d57;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d57<>'' then begin
                    Evaluate(c43,d57);
                end;
                end;
            end;
        }
        field(59;d58;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d58<>'' then begin
                    Evaluate(c44,d58);
                end;
                end;
            end;
        }
        field(60;d59;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d59<>'' then begin
                    Evaluate(c45,d59);
                end;
                end;
            end;
        }
        field(61;d60;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d60<>'' then begin
                    Evaluate(c46,d60);
                end;
                end;
            end;
        }
        field(62;d61;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d61<>'' then begin
                    Evaluate(c47,d61);
                end;
                end;
            end;
        }
        field(63;d62;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d62<>'' then begin
                    Evaluate(c48,d62);
                end;
                end;
            end;
        }
        field(64;d63;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d63<>'' then begin
                    Evaluate(c49,d63);
                end;
                end;
            end;
        }
        field(65;d64;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d64<>'' then begin
                    Evaluate(c50,d64);
                end;
                end;
            end;
        }
        field(66;d65;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d65<>'' then begin
                    Evaluate(c51,d65);
                end;
                end;
            end;
        }
        field(67;d66;Code[30])
        {

            trigger OnValidate()
            begin
                if conta>10000 then begin
                if d66<>'' then begin
                    Evaluate(c52,d66);
                end;
                end;
            end;
        }
        field(68;Producto;Code[20])
        {
        }
        field(69;c1;Decimal)
        {
        }
        field(70;c2;Decimal)
        {
        }
        field(71;c3;Decimal)
        {
        }
        field(72;c4;Decimal)
        {
        }
        field(73;c5;Decimal)
        {
        }
        field(74;c6;Decimal)
        {
        }
        field(75;c7;Decimal)
        {
        }
        field(76;c8;Decimal)
        {
        }
        field(77;c9;Decimal)
        {
        }
        field(78;c10;Decimal)
        {
        }
        field(79;c11;Decimal)
        {
        }
        field(80;c12;Decimal)
        {
        }
        field(81;c13;Decimal)
        {
        }
        field(82;c14;Decimal)
        {
        }
        field(83;c15;Decimal)
        {
        }
        field(84;c16;Decimal)
        {
        }
        field(85;c17;Decimal)
        {
        }
        field(86;c18;Decimal)
        {
        }
        field(87;c19;Decimal)
        {
        }
        field(88;c20;Decimal)
        {
        }
        field(89;c21;Decimal)
        {
        }
        field(90;c22;Decimal)
        {
        }
        field(91;c23;Decimal)
        {
        }
        field(92;c24;Decimal)
        {
        }
        field(93;c25;Decimal)
        {
        }
        field(94;c26;Decimal)
        {
        }
        field(95;c27;Decimal)
        {
        }
        field(96;c28;Decimal)
        {
        }
        field(97;c29;Decimal)
        {
        }
        field(98;c30;Decimal)
        {
        }
        field(99;c31;Decimal)
        {
        }
        field(100;c32;Decimal)
        {
        }
        field(101;c33;Decimal)
        {
        }
        field(102;c34;Decimal)
        {
        }
        field(103;c35;Decimal)
        {
        }
        field(104;c36;Decimal)
        {
        }
        field(105;c37;Decimal)
        {
        }
        field(106;c38;Decimal)
        {
        }
        field(107;c39;Decimal)
        {
        }
        field(108;c40;Decimal)
        {
        }
        field(109;c41;Decimal)
        {
        }
        field(110;c42;Decimal)
        {
        }
        field(111;c43;Decimal)
        {
        }
        field(112;c44;Decimal)
        {
        }
        field(113;c45;Decimal)
        {
        }
        field(114;c46;Decimal)
        {
        }
        field(115;c47;Decimal)
        {
        }
        field(116;c48;Decimal)
        {
        }
        field(117;c49;Decimal)
        {
        }
        field(118;c50;Decimal)
        {
        }
        field(119;c51;Decimal)
        {
        }
        field(120;c52;Decimal)
        {
        }
        field(121;dd1;Decimal)
        {
        }
        field(122;dd2;Decimal)
        {
        }
        field(123;dd3;Decimal)
        {
        }
        field(124;dd4;Decimal)
        {
        }
        field(125;dd5;Decimal)
        {
        }
        field(126;dd6;Decimal)
        {
        }
        field(127;dd7;Decimal)
        {
        }
        field(128;dd8;Decimal)
        {
        }
        field(129;dd9;Decimal)
        {
        }
        field(130;dd10;Decimal)
        {
        }
        field(131;dd11;Decimal)
        {
        }
        field(132;dd12;Decimal)
        {
        }
        field(133;SUMATEN60;Decimal)
        {
        }
        field(134;SUMATEN90;Decimal)
        {
        }
        field(135;SUMATEN180;Decimal)
        {
        }
        field(136;SUMATEN360;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;conta)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
}

