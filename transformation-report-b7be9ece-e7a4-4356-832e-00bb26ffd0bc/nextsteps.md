# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any runtime-level compatibility concerns.

### 5. Run the Application Locally

Start the application locally and verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that key features such as routing, data access, authentication, and any third-party integrations behave as expected.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate business logic and integration points:

```bash
dotnet test
```

Review the test results and address any failures before proceeding further.

### 7. Review Configuration Files

- Confirm that `web.config` settings have been migrated to `appsettings.json` where applicable.
- Verify that connection strings, application settings, and environment-specific values are correctly represented in the new configuration system.
- Ensure `Program.cs` and `Startup.cs` (or the consolidated `Program.cs` in minimal hosting model) correctly configure services and middleware.

### 8. Validate Static Files and wwwroot

Ensure that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, which is the expected location for static files in cross-platform .NET web applications.

### 9. Check Database Migrations

If the project uses Entity Framework, verify that existing migrations are compatible with the current version of EF Core:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

Apply migrations to a development database and confirm the schema is correct:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and verify that all required files are present before deploying to the target environment.