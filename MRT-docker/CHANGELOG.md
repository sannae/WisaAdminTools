[*] Aggiunto Configure-iis.ps1 al dockerfile per creare Test application pool e directory virtuale /mpassw e associarli
[*] Abilitati errori dettagliati su web.config:

  <configuration>
      <system.webServer>
          <httpErrors errorMode="Detailed" />
          <asp scriptErrorSentToBrowser="true"/>
      </system.webServer>
      <system.web>
          <customErrors mode="Off"/>
          <compilation debug="true"/>
      </system.web>
  </configuration>

