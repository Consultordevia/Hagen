dotnet
{
	assembly("Microsoft Office 15.0 Object Library")
	{

		type("CommandBars";"CommandBars"){}
	}
	assembly("Microsoft Outlook 15.0 Object Library")
	{

		type("_OlkDateControl";"_OlkDateControl"){}
		type("_OlkCommandButton";"_OlkCommandButton"){}
	}
	assembly("Windows Script Host Object Model")
	{

		type("WshShell";"WshShell"){}
	}
	assembly("System")
	{

		Culture='neutral';
		PublicKeyToken='b77a5c561934e089';
		Version='4.0.0.0';

		type("System.Diagnostics.Process";"Process"){}
		type("System.Diagnostics.DataReceivedEventArgs";"DataReceivedEventArgs"){}
	}
	assembly("mscorlib")
	{

		Culture='neutral';
		PublicKeyToken='b77a5c561934e089';
		Version='4.0.0.0';

		type("System.EventArgs";"EventArgs"){}
	}
}
