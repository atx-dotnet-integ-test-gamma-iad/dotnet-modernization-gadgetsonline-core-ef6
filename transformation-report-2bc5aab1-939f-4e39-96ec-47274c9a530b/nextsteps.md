# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves as expected compared to the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing logic has not regressed:

```bash
dotnet test
```

Review test results and address any failures before proceeding.

### 6. Review Removed or Changed APIs

Check the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types, which may have moved to `Microsoft.AspNetCore.Http`
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry or certain `System.Drawing` features

### 7. Review Static Files and Configuration

Confirm that files such as `appsettings.json` are present and correctly configured, replacing any legacy `Web.config` or `App.config` settings where applicable. Verify that connection strings, application settings, and environment-specific values have been migrated.

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection string in `appsettings.json` is correct and that the application can connect and perform operations as expected. If Entity Framework is in use, run the following to verify the model is consistent with the database:

```bash
dotnet ef migrations list
```

### 9. Manual Functional Testing

Perform manual testing of the primary user-facing features of the application to confirm end-to-end functionality is intact. Pay particular attention to areas that relied heavily on .NET Framework-specific behavior.