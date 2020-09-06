- [x] Aggiunto comando `Start-process 'msiexec'` al dockerfile per installare Crystal Reports 32 e 64-bit
- [x] Aggiunto `Configure-iis.ps1` al dockerfile per a) creare la directory virtuale /mpassw, b) creare e configurare l'application pool Test, c) associarli tra di loro
- [x] Abilitati errori dettagliati su web.config:
```
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
```
