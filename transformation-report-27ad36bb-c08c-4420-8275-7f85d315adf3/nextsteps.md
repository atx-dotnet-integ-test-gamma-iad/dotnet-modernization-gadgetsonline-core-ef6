# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas of risk.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your organization's supported .NET version.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in .NET Framework but have changed behavior or limited support in cross-platform .NET, including:

- `System.Web` namespaces (not available in cross-platform .NET)
- `HttpContext` and related ASP.NET types (replaced by ASP.NET Core equivalents)
- Windows-specific APIs such as the registry, WMI, or COM interop
- `ConfigurationManager` (requires the `System.Configuration.ConfigurationManager` NuGet package)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to verify runtime behavior matches expectations from the original project.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests to determine whether failures are caused by behavioral differences between .NET Framework and cross-platform .NET.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains all configuration values previously held in `Web.config` or `App.config`.
- Verify that static files, views, and other content files are included correctly in the project and are accessible at runtime.

### 8. Validate Database Connectivity

If the application uses a database, confirm that connection strings in `appsettings.json` are correct and that the application can successfully connect and perform queries at runtime.

### 9. Check Middleware and Startup Configuration

If this is an ASP.NET Core project, review `Program.cs` or `Startup.cs` to ensure all necessary middleware is registered, including authentication, authorization, routing, and static file serving.