            [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

            $objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon

            $objNotifyIcon.Icon = [System.Drawing.SystemIcons]::Information
            $objNotifyIcon.BalloonTipIcon = "Info" 
            $objNotifyIcon.BalloonTipText = "Description" 
            $objNotifyIcon.BalloonTipTitle = "Title"
            $objNotifyIcon.Visible = $True
            $objNotifyIcon.ShowBalloonTip(10000)
            [System.Environment]::Exit(0)
            Start-Sleep 500
        