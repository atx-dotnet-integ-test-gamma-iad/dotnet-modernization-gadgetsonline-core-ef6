# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages. Address any packages that do not have compatible versions for the target framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors and warnings:

```bash
dotnet build --configuration Release
```

Review any warnings in the output, particularly those related to deprecated APIs, nullable reference types, or platform compatibility. While warnings do not block a build, they may indicate areas that require attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary functionality to confirm expected behavior.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are caused by the migration or pre-existing issues.

### 6. Review Removed or Changed APIs

Cross-platform .NET removes or changes certain APIs that were available in .NET Framework. Review the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm that all usages have been replaced with ASP.NET Core equivalents.
- **Configuration**: Confirm that `web.config`-based configuration has been replaced with `appsettings.json` and the `Microsoft.Extensions.Configuration` system.
- **Authentication and Authorization**: Confirm that any legacy membership or identity providers have been replaced with ASP.NET Core Identity or equivalent middleware.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that database migrations are functioning correctly.

### 7. Check Static Files and Views

If the project is a web application, verify that static files, Razor views, or other front-end assets are being served correctly. Confirm that the `wwwroot` folder structure is in place and that the middleware pipeline in `Program.cs` or `Startup.cs` includes:

```csharp
app.UseStaticFiles();
```

### 8. Deployment

Once local validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target server or hosting environment. Confirm the target environment has the appropriate .NET runtime installed by running:

```bash
dotnet --info
```

Verify the runtime version matches the `<TargetFramework>` specified in the project file.