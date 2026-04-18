# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an actively supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its core functionality, paying attention to any runtime exceptions that would not have been caught at build time.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test output for any failures and address them before proceeding.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework, particularly around:

- `System.Web` — This namespace is not available in cross-platform .NET. Ensure no remaining references exist.
- `HttpContext` and related types — Verify these have been replaced with their ASP.NET Core equivalents.
- Windows-specific APIs such as the registry, WCF server-side hosting, or `System.Drawing` (GDI+) — Confirm these have been replaced or removed.

Search the codebase for any remaining usages:

```bash
grep -r "System.Web" GadgetsOnline/
```

### 7. Review Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` and that the application reads configuration through `IConfiguration` rather than `ConfigurationManager` where applicable.

### 8. Validate Static Files and wwwroot

If the project is a web application, confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder and are being served correctly when the application runs.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 10. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed:

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download). Start the application on the target environment and perform a final round of smoke testing.