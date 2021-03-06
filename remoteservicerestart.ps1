# THE ULTIMATE WINDOWS SERVICE CONTROLLER
# Start Stop and Restart services on any machine that is connected to the network
# Created by Ben just for educational purposes and lols
# Playing around with the Winform GUI options you can utilize

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

#Need to change these functions because the current cmdlet is for local opperation only.
$Icon = New-Object system.drawing.icon ("C:\users\prenticb\documents\IT\Scripts\Restart Service Gui\sicon.ico")

function StopThing
{
Stop-Service $x 
}
function StartThing 
{
Start-Service $x
}
function RestartThing
{
Restart-Service $x 
}
function MyButtonClick()
{
#Clearing the items in the ListBox
$objListBox.Items.Clear()
#Retrieving services from Specified PC
$services = Get-Service -ComputerName $pc
#Loop through available services on PC to show user in list.
foreach ($service in $services)
{
[void] $objListBox.Items.Add($service.Name)
}
}

#GUI Window
$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "ULTIMATE SERVICER"
$objForm.Size = New-Object System.Drawing.Size(325,400) 
$objForm.StartPosition = "CenterScreen"
$objForm.FormBorderStyle = "FixedSingle"
$objForm.MaximizeBox = $false
$objForm.Icon = $Icon

#Input box for Admin to specify PC name which binds to $pc
$objTextBox = New-Object System.Windows.Forms.TextBox
$objTextBox.Location = New-Object System.Drawing.Point(10,10)
$objTextBox.Size = New-Object System.Drawing.Size(150,20)
$objTextBox.Text = "Machine Name..."
$objForm.Controls.Add($objTextBox)


#Enter/Ok button to set Variable $pc
$objOKButton = New-Object System.Windows.Forms.Button
$objOKButton.Location = New-Object System.Drawing.Point(161,10)
$objOKButton.Size = New-Object System.Drawing.Size(30,20)
$objOKButton.Text = "Ok"
$objOKButton.Add_Click({$pc = $objTextBox.Text; MyButtonClick})
$objForm.AcceptButton = $objOKButton
$objForm.Controls.Add($objOKButton)

#Service:Status Label
$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,40)
$objLabel.Size = New-Object System.Drawing.Size(280,20)
$objLabel.Text = "Service:Status"
$objForm.Controls.Add($objLabel)

#GUI Start button
$StartButton = New-Object System.Windows.Forms.Button
$StartButton.Location = New-Object System.Drawing.Size(200,340)
$StartButton.Size = New-Object System.Drawing.Size(75,23)
$StartButton.Text = "Start"
$StartButton.Add_Click({$x = $objListBox.SelectedItem; StartThing})
$objForm.Controls.Add($StartButton)

#GUI Restart button
$RestartButton = New-Object System.Windows.Forms.Button
$RestartButton.Location = New-Object System.Drawing.Size(125,340)
$RestartButton.Size = New-Object System.Drawing.Size(75,23)
$RestartButton.Text = "Restart"
$RestartButton.Add_Click({$x = $objListBox.SelectedItem; RestartThing})
$objForm.Controls.Add($RestartButton)

#GUI Stop button
$Stop = New-Object System.Windows.Forms.Button
$Stop.Location = New-Object System.Drawing.Size(50,340)
$Stop.Size = New-Object System.Drawing.Size(75,23)
$Stop.Text = "Stop"
$Stop.Add_Click({$x = $objListBox.SelectedItem; StopThing})
$objForm.Controls.Add($Stop)

#List of Services
$objListBox = New-Object System.Windows.Forms.ListBox
$objListBox.Location = New-Object System.Drawing.Size(10,60)
$objListBox.Size = New-Object System.Drawing.Size(300,20)
$objListBox.Height = 280

#Adding list to Form and Showing the form.
$objForm.Controls.Add($objListBox) 
$objForm.Topmost = $True
$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()