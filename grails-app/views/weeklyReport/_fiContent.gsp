<g:each in="${finished}" status="i" var="f">
    <div>
        <span style="width: 70px;text-align: left; color: #0000ff;display: inline-block">${f.serial}</span>
        <span>${f.title}</span>
    </div>
</g:each>